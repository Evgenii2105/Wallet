//
//  Metrics.swift
//  Wallet
//
//  Created by Евгений Фомичев on 06.07.2025.
//

import Foundation

struct Metrics: Decodable {
    let marketData: MarketData
    let roiData: RoiData
    
    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
        case roiData = "roi_data"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.marketData = try container.decode(MarketData.self, forKey: .marketData)
        self.roiData = try container.decode(RoiData.self, forKey: .roiData)
    }
}
