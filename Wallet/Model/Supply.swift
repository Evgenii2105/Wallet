//
//  Supply.swift
//  Wallet
//
//  Created by Евгений Фомичев on 15.07.2025.
//

import Foundation

struct Supply: Decodable {
    
    let circulating: Double
    
    enum CodingKeys: String, CodingKey {
        case circulating = "circulating"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.circulating = try container.decode(Double.self, forKey: .circulating)
    }
}
