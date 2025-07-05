//
//  Status.swift
//  Wallet
//
//  Created by Евгений Фомичев on 05.07.2025.
//

struct Status: Decodable {
    let elapsed: Int
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case elapsed = "elapsed"
        case timestamp = "timestamp"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.elapsed = try container.decode(Int.self, forKey: .elapsed)
        self.timestamp = try container.decode(String.self, forKey: .timestamp)
    }
}
