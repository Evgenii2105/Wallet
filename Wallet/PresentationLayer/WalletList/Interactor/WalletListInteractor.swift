//
//  WalletListInteractor.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

protocol WalletListInteractor: AnyObject {
    func setupDataSource()
    func didLogout()
    func sortedHeader(by sort: WalletListInteractorImpl.CoinsSorting)
    func showDetailsCoin(item: WalletListItem)
    func getSortState(sort: WalletListInteractorImpl.CoinsSorting) -> UIAction.State
    func getSortAction(sort: WalletListInteractorImpl.CoinsSorting) -> (() -> Void)
}

protocol WalletListListener: AnyObject {
    func needsToLogout()
}
