//
//  WalletInteractorImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListInteractorImpl: WalletListInteractor {
    
    weak var presenter: WalletListPresenterOutput?
    var router: WalletListRouter
    private let dataManager: DataManagerService = DataManagerServiceImpl()
    private var coins: [CoinData] = []
    private weak var listener: WalletListListener?
    
    init(router: WalletListRouter, listener: WalletListListener?) {
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
        listener?.needsToLogout()
    }
    
    func sortedHeader(by sort: CoinsListHeaderView.CoinsSorting) {
        var sortedCoins = coins
        switch sort {
        case .sortedDefault:
            break
        case .sortedDescending:
            sortedCoins = coins.sorted(by: { $0.metrics.marketData.priceUSD > $1.metrics.marketData.priceUSD })
        case .sortedAscending:
            sortedCoins = coins.sorted(by: { $0.metrics.marketData.priceUSD < $1.metrics.marketData.priceUSD })
        }
        presenter?.didGet(walletListItems: sortedCoins.map({ $0.mapToItem() })
        )
    }
    
    func showDetailsCoin(item: WalletListItem) {
        guard let coin = coins.first(where: { $0.id == item.id }) else { return }
        router.showDetailsCoin(coin: coin)
    }
}
