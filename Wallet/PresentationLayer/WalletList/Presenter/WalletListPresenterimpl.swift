//
//  WalletListPresenterimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

final class WalletListPresenterimpl: WalletListPresenter {
    
    weak var view: WalletListViewController?
    private let interactor: WalletListInteractor
    
    init(view: WalletListViewController, interactor: WalletListInteractor) {
        self.view = view
        self.interactor = interactor
    }
}
