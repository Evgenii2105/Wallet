//
//  CoinDetailsInteractorimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class CoinDetailsInteractorImpl: CoinDetailsInteractor {
   
    weak var presenter: CoinDetailsPresenterOutput?
    private let router: CoinDetailsRouter
    private var coin: CoinData
    
    init(coin: CoinData, router: CoinDetailsRouter) {
        self.router = router
        self.coin = coin
    }
    
    func setupDataSource() {
        presenter?.didGet(coin: coin, period: .day)
    }
    
    func timePeriodChanged(to period: CoinDetailsViewController.TimePeriod) {
        changeCoinSource(for: period)
    }
    
    private func changeCoinSource(for period: CoinDetailsViewController.TimePeriod) {
        presenter?.didGet(coin: coin, period: period)
    }
}
