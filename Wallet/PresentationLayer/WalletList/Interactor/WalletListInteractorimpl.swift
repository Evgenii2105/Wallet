//
//  WalletInteractorimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListInteractorimpl: WalletListInteractor {
    
    weak var presenter: WalletListPresenterOutput?
    var router: WalletListRouter
    private let dataManager: DataManagerService = DataManagerServiceImpl()
    private var coins: [WalletListItem] = []
    
    init(router: WalletListRouter) {
        self.router = router
    }
    
    func setupDataSource() {
        dataManager.getCoins { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let coinsData):
                    self.coins = coinsData.map({
                        WalletListItem(
                            id: $0.id,
                            symbol: $0.symbol,
                            name: $0.name,
                            price: $0.marketData.priceUSD,
                            changePrice: $0.marketData.percentChangeUSDLast24Hours,
                            image: nil
                        )
                    })
                    self.presenter?.didCoins(coins: self.coins)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func didLogout() {
        router.didLogout()
    }
    
    func sortedHeader(by sort: CoinsListHeaderView.CoinsSorting) {
       var sortedCoins = coins
        switch sort {
        case .sortedDefault:
            break
        case .sortedDescending:
            sortedCoins = coins.sorted(by: { $0.price > $1.price })
        case .sortedAscending:
            sortedCoins = coins.sorted(by: { $0.price < $1.price })
        }
        presenter?.didCoins(coins: sortedCoins)
    }
    
    func showDetailsCoin(coin: WalletListItem) {
        router.showDetailsCoin(coin: coin)
    }
}
