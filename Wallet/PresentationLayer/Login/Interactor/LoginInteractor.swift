//
//  LoginInteractor.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol LoginInteractor: AnyObject {
    func handleAuth(login: String?, password: String?)
}
