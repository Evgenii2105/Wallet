//
//  CoinsList.swift
//  Wallet
//
//  Created by Евгений Фомичев on 03.07.2025.
//

import Foundation

struct CoinData: Decodable {
    let id: String
    let serialId: Int
    let symbol: String
    let name: String
    let slug: String
    let metrics: Metrics
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case serialId = "serial_id"
        case symbol = "symbol"
        case name = "name"
        case slug = "slug"
        case metrics = "metrics"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.serialId = try container.decode(Int.self, forKey: .serialId)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.metrics = try container.decode(Metrics.self, forKey: .metrics)
    }
}
