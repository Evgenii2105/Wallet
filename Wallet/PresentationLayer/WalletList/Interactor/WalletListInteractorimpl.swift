//
//  WalletInteractorimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListInteractorimpl: WalletListInteractor {
    
    weak var presenter: WalletListPresenter?
    var router: WalletListRouter
    
    init(router: WalletListRouter) {
        self.router = router
    }
    
}
