//
//  WalletListInteractor.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol WalletListInteractor: AnyObject {
    func setupDataSource()
    func didLogout()
    func sortedHeader(by sort: CoinsListHeaderView.CoinsSorting)
    func showDetailsCoin(coin: WalletListItem)
}
