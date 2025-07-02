//
//  NetworkImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class NetworkImpl {
    
//    enum BaseUrl {
//        static let baseURL = ""
//    }
//    
//    enum ApiMethod: String {
//        case get = "GET"
//        case post = "POST"
//        case delete = "DELETE"
//    }
//    
//    enum EndPoint {
//        case coins
//        case detailsCoins(id: Int)
//        
//        var scheme: String {
//            return "https"
//        }
//        
//        var path: String {
//            switch self {
//            case .coins:
//                
//            case .detailsCoins(let id):
//                
//            }
//        }
//        
//        var method: ApiMethod {
//            switch self {
//            case .coins:
//                
//            case .detailsCoins(let id):
//                
//            }
//        }
//    }
//    
//    func requset<T: Decodable>(endPoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        guard let urlRequest = createRequest(endPoint: endPoint) else {
//            return completion(.failure(.invalidURL))
//        }
//    }
//}
//
//private extension NetworkImpl {
//    
//    func request<T: Decodable>(urlReuest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> ()) {
//        let task = URLSession.shared.dataTask(with: urlReuest) {
//            data, _, error in
//            guard let data else { return completion(.failure(.noData)) }
//            
//            let decoder = JSONDecoder()
//            
//            do {
//                let decodedData = try decoder.decode(T.self, from: data)
//                completion(.success(decodedData))
//            }
//            catch {
//                completion(.failure(.decodingFailed(error)))
//            }
//        }
//        task.resume()
//    }
//    
//    func createRequest(endPoint: EndPoint) -> URLRequest? {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = endPoint.scheme
//        urlComponents.host = BaseUrl.baseURL
//        urlComponents.path = endPoint.path
//        
//        guard let url = urlComponents.url else { return nil }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = endPoint.method.rawValue
////        urlRequest.setValue("dfb1b814-db03-4878-bcf4-c54787098b5a", forHTTPHeaderField: "X-API-KEY")
////        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        return urlRequest
//    }
}
