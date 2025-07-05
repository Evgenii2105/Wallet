//
//  LoginPresenter.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol LoginPresenter: AnyObject {
    func handleAuth(login: String?, password: String?)
}

protocol LoginPresenterOutput: AnyObject {
    func clearTextField()
}
