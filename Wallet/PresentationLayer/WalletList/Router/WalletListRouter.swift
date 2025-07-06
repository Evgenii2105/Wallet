//
//  WalletListRouter.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol WalletListRouter: AnyObject {
    func showDetailsCoin(coin: CoinData)
}
