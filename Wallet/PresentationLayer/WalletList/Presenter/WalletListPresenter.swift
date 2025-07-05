//
//  WalletListPresenter.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol WalletListPresenter: AnyObject {
    func setupDataSource()
    func didLogout()
    func refreshTable()
    func sortedHeader(by sort: CoinsListHeaderView.CoinsSorting)
    func showDetailsCoin(coin: WalletListItem)
}

protocol WalletListPresenterOutput: AnyObject {
    func didCoins(coins: [WalletListItem])
}
