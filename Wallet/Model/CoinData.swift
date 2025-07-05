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
    let marketData: MarketData
    
//    let marketCap: Double
//    let circulatingSupply: Double
//    let maxSupply: Double
//    let volume24h: Double
//    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case serialId = "serial_id"
        case symbol = "symbol"
        case name = "name"
        case slug = "slug"
        case metrics = "metrics"
        case marketData = "market_data"
//        case marketCap = "marketcap_current_mcap"
//        case circulatingSupply = "circulating_supply"
//        case maxSupply = "max_supply"
//        case volume24h = "volume_last_24_hours"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.serialId = try container.decode(Int.self, forKey: .serialId)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        let metrics = try container.decode(Metrics.self, forKey: .metrics)
        self.marketData = metrics.marketData
        
        //self.marketCap = try container.decode(Double.self, forKey: .)
    }
}

struct Metrics: Decodable {
    let marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.marketData = try container.decode(MarketData.self, forKey: .marketData)
    }
}

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
