//
//  WalletListPresenterimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListPresenterimpl: WalletListPresenter {
  
    weak var view: WalletListView?
    private let interactor: WalletListInteractor
        
    init(view: WalletListViewController, interactor: WalletListInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func setupDataSource() {
        interactor.setupDataSource()
    }
    
    func didLogout() {
        interactor.didLogout()
    }
    
    func refreshTable() {
        interactor.setupDataSource()
    }
    
    func sortedHeader(by sort: CoinsListHeaderView.CoinsSorting) {
        interactor.sortedHeader(by: sort)
    }
    
    func showDetailsCoin(coin: WalletListItem) {
        interactor.showDetailsCoin(coin: coin)
    }
}

extension WalletListPresenterimpl: WalletListPresenterOutput {
    func didCoins(coins: [WalletListItem]) {
        view?.didCoins(coins: coins)
    }
}
