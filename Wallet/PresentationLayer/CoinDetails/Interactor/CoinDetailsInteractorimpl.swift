//
//  CoinDetailsInteractorimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class CoinDetailsInteractorimpl: CoinDetailsInteractor {
    
    weak var presenter: CoinDetailsPresenter?
    private let router: CoinDetailsRouter
    
    init(router: CoinDetailsRouter) {
        self.router = router
    }
}
