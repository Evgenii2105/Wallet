//
//  Datamanager.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol DataManagerService: AnyObject {
    func getCoins()
    func getCoinsDetails()
}

final class DataManagerServiceImpl: DataManagerService {
 
    private let client = NetworkImpl()
    
    func getCoins() {
        
    }
    
    func getCoinsDetails() {
        
    }
    
}
