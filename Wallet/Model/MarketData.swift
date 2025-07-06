//
//  MarketData.swift
//  Wallet
//
//  Created by Евгений Фомичев on 06.07.2025.
//

import Foundation

struct MarketData: Decodable {
    let priceUSD: Double
    let percentChangeUSDLast24Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case percentChangeUSDLast24Hours = "percent_change_usd_last_24_hours"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.percentChangeUSDLast24Hours = try container.decode(Double.self, forKey: .percentChangeUSDLast24Hours)
        self.priceUSD = try container.decode(Double.self, forKey: .priceUSD)
    }
}
