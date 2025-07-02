//
//  NetworkError.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(String)
    case noData
    case decodingFailed(Error)
}
