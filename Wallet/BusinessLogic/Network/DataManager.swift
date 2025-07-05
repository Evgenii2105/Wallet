//
//  Datamanager.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol DataManagerService: AnyObject {
    func getCoins(coinsResult: @escaping (Result<[CoinData], NetworkError>) -> Void)
}

final class DataManagerServiceImpl: DataManagerService {
    
    private let client = NetworkImpl()
    
    func getCoins(coinsResult: @escaping (Result<[CoinData], NetworkError>) -> Void) {
        client.request(endPoint: .assetsMetrics) { (result: Result<CoinMetricsResponse, NetworkError>) in
            switch result {
            case .success(let coinsResponse):
                coinsResult(.success(coinsResponse.data))
            case .failure(let error):
                coinsResult(.failure(.decodingFailed(error)))
            }
        }
    }
}
