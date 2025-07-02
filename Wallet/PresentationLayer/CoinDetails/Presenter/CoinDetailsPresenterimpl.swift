//
//  CoinDetailsPresenterimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

final class CoinDetailsPresenterimpl: CoinDetailsPresenter {
    
    weak var view: CoinDetailsView?
    private let interactor: CoinDetailsInteractor
    
    init(view: CoinDetailsView, interactor: CoinDetailsInteractor) {
        self.view = view
        self.interactor = interactor
    }
}
