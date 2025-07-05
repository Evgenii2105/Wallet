//
//  WalletListView.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol WalletListView: AnyObject {
    func didCoins(coins: [WalletListItem])
}
