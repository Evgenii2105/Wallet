//
//  UserStorageimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol UserStorage: AnyObject {
    var isUserLoggedIn: Bool { get }
}

final class UserStorageImpl: UserStorage {
    
    enum ValidationState {
        case success
        case wrongPassword
    }
    
    private let hardcodedLogin = "1234"
    private let hardcodedPassword = "1234"
    
    var isUserLoggedIn: Bool {
        return !UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    }
    
    static let sharedInstance = UserStorageImpl()
    private let userDefaults = UserDefaults.standard
    
    init() {
    }
    
    func loginUser() {
        userDefaults.set(true, forKey: "isUserLoggedIn")
        userDefaults.synchronize()
    }
    
    func logout() {
        userDefaults.set(false, forKey: "isUserLoggedIn")
        userDefaults.synchronize()
    }
    
    func validateUserPassword(login: String, password: String) -> ValidationState {
        if login == hardcodedLogin && password == hardcodedPassword {
            loginUser()
            return .success
        }
        return .wrongPassword
    }
}
