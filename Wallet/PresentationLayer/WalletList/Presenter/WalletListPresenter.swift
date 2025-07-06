//
//  WalletListPresenter.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

protocol WalletListPresenter: AnyObject {
    func setupDataSource()
    func didLogout()
    func refreshTable()
    func sortedHeader(by sort: WalletListInteractorImpl.CoinsSorting)
    func showDetailsCoin(coin: WalletListItem)
    func getHeaderMenu() -> UIMenu
}

protocol WalletListPresenterOutput: AnyObject {
    func didGet(walletListItems: [WalletListItem])
    func reconfigureMenu()
}
