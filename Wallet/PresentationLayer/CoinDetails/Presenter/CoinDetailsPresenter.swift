//
//  CoinDetailsPresenter.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol CoinDetailsPresenter: AnyObject {
    func setupDataSource()
    func timePeriodChanged(to period: CoinDetailsViewController.TimePeriod)
}

protocol CoinDetailsPresenterOutput: AnyObject {
    func didGet(coin: CoinData, period: CoinDetailsViewController.TimePeriod)
}
