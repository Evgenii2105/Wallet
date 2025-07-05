//
//  CoinMetricsResponse.swift
//  Wallet
//
//  Created by Евгений Фомичев on 05.07.2025.
//

import Foundation

struct CoinMetricsResponse: Decodable {
    let status: Status
    let data: [CoinData]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([CoinData].self, forKey: .data)
        self.status = try container.decode(Status.self, forKey: .status)
    }
}
