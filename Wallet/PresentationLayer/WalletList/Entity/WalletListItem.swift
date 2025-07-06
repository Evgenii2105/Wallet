//
//  WalletListItem.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit
import Foundation

struct WalletListItem {
    let id: String
    let symbol: String
    let name: String
    let price: Double
    let changePrice: Double
    let image: UIImage?
}

extension CoinData {
    
    func mapToItem() -> WalletListItem {
        return WalletListItem(
            id: self.id,
            symbol: self.symbol,
            name: self.name,
            price: self.metrics.marketData.priceUSD,
            changePrice: self.metrics.marketData.percentChangeUSDLast24Hours,
            image: nil
        )
    }
}
