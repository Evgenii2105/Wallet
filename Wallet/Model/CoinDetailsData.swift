//
//  CoinDetailsData.swift
//  Wallet
//
//  Created by Евгений Фомичев on 05.07.2025.
//

//import Foundation
//
//struct CoinDetailsData: Decodable {
//    let id: String
//    let name: String
//    let symbol: String
//    let marketData: ExtendedMarketData
//    
//    enum CodingKeys: String, CodingKey {
//        case id = 
//    }
//}
//
//struct ExtendedMarketData: Decodable {
//    let priceUSD: Double
//    let percentChange24h: Double
//    let marketCap: Double
//    let circulatingSupply: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case priceUSD = "price_usd"
//        case percentChange24h = "percent_change_usd_last_24_hours"
//        case marketCap = "marketcap_current_mcap"
//        case circulatingSupply = "circulating_supply"
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.priceUSD = try container.decode(Double.self, forKey: .priceUSD)
//        self.percentChange24h = try container.decode(Double.self, forKey: .percentChange24h)
//        self.marketCap = try container.decode(Double.self, forKey: .marketCap)
//        self.circulatingSupply = try container.decode(Double.self, forKey: .circulatingSupply)
//    }
//}
