//
//  WalletInteractorImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListInteractorImpl: WalletListInteractor {
    
    enum CoinsSorting: CaseIterable {
        case sortDefault
        case sortDescending
        case sortAscending
        
        var title: String {
            switch self {
            case .sortDefault:
                "Сортировка по умолчанию"
            case .sortDescending:
                "Сортировка по убыванию"
            case .sortAscending:
                "Сортировка по возрастанию"
            }
        }
    }
    
    weak var presenter: WalletListPresenterOutput?
    private var router: WalletListRouter
    private let dataManager: DataManagerService = DataManagerServiceImpl()
    private var coins: [CoinData] = []
    private weak var listener: WalletListListener?
    private var currentSorted: CoinsSorting = .sortDefault
    private let userStorage: UserStorage
    
    init(userStorage: UserStorage, router: WalletListRouter, listener: WalletListListener?) {
        self.userStorage = userStorage
        self.router = router
        self.listener = listener
    }
    
    func setupDataSource() {
        dataManager.getCoins { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let coinsData):
                    self.coins = coinsData
                    let walletListItems = coinsData.map({
                        $0.mapToItem()
                    })
                    self.presenter?.didGet(walletListItems: walletListItems)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func didLogout() {
        userStorage.logout()
        listener?.needsToLogout()
    }
    
    func sortedHeader(by sort: CoinsSorting) {
        var sortCoins = coins
        switch sort {
        case .sortDefault:
            break
        case .sortDescending:
            sortCoins = coins.sorted(by: { $0.metrics.marketData.priceUSD > $1.metrics.marketData.priceUSD })
        case .sortAscending:
            sortCoins = coins.sorted(by: { $0.metrics.marketData.priceUSD < $1.metrics.marketData.priceUSD })
        }
        presenter?.didGet(walletListItems: sortCoins.map({ $0.mapToItem() }))
    }
    
    func getSortState(sort: CoinsSorting) -> UIAction.State {
        currentSorted == sort ? .on : .off
    }
    
    func getSortAction(sort: CoinsSorting) -> (() -> Void) {
        return { [weak self] in
            guard let self else { return }
            self.currentSorted = sort
            presenter?.reconfigureMenu()
            sortedHeader(by: sort)
        }
    }
    
    func showDetailsCoin(item: WalletListItem) {
        guard let coin = coins.first(where: { $0.id == item.id }) else { return }
        router.showDetailsCoin(coin: coin)
    }
}
