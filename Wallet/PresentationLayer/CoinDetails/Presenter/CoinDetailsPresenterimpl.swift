//
//  CoinDetailsPresenterimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

final class CoinDetailsPresenterImpl: CoinDetailsPresenter {
   
    weak var view: CoinDetailsView?
    private let interactor: CoinDetailsInteractor
    
    init(view: CoinDetailsView, interactor: CoinDetailsInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func setupDataSource() {
        interactor.setupDataSource()
    }
    
    func timePeriodChanged(to period: CoinDetailsViewController.TimePeriod) {
        interactor.timePeriodChanged(to: period)
    }
}

extension CoinDetailsPresenterImpl: CoinDetailsPresenterOutput {
    
    func didGet(coin: CoinData, period: CoinDetailsViewController.TimePeriod) {
        view?.didGet(coin: coin, period: period)
    }
}
