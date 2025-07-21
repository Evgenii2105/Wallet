//
//  RoiData.swift
//  Wallet
//
//  Created by Евгений Фомичев on 06.07.2025.
//

import Foundation

struct RoiData: Decodable {
    let percentChangeOneWeek: Double
    let percentChangeOneMonth: Double
    let percentChangeThreeMonth: Double?
    let percentChangeOneYear: Double?
    
    enum CodingKeys: String, CodingKey {
        case percentChangeOneWeek = "percent_change_last_1_week"
        case percentChangeOneMonth = "percent_change_last_1_month"
        case percentChangeThreeMonth = "percent_change_last_3_months"
        case percentChangeOneYear = "percent_change_last_1_year"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.percentChangeOneWeek = try container.decode(Double.self, forKey: .percentChangeOneWeek)
        self.percentChangeOneMonth = try container.decode(Double.self, forKey: .percentChangeOneMonth)
        self.percentChangeThreeMonth = try container.decodeIfPresent(Double.self, forKey: .percentChangeThreeMonth)
        self.percentChangeOneYear = try container.decodeIfPresent(Double.self, forKey: .percentChangeOneYear)
    }
}
