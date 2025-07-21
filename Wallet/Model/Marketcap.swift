//
//  Marketcap.swift
//  Wallet
//
//  Created by Евгений Фомичев on 15.07.2025.
//

import Foundation

struct MarketCap: Decodable {
    
    let currentMarketCapUSD: Double
    
    enum CodingKeys: String, CodingKey {
        case currentMarketCapUSD = "current_marketcap_usd"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.currentMarketCapUSD = try container.decode(Double.self, forKey: .currentMarketCapUSD)
    }
}
