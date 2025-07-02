//
//  LoginInteractorimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class LoginInteractorimpl: LoginInteractor {
   
    weak var presenter: LoginPresenterOutput?
    var router: LoginRouter
    var userStorage = UserStorageImpl()
    var alertFactory: AlertFactoryService
    
    init(router: LoginRouter, alertFactory: AlertFactoryService) {
        self.router = router
        self.alertFactory = alertFactory
    }
    
    func handleAuth(login: String?, password: String?) {
        guard let login, !login.isEmpty,
            let password, !password.isEmpty else {
            let alert = alertFactory.failureLoginIsEmpty(message: "Введите логин и пароль")
            router.showAlert(alert: alert)
            return
        }
        switch userStorage.validateUserPassword(login: login, password: password) {
        case .success:
            router.openWallet()
        case .wrongPassword:
            let alert = alertFactory.failureLoginIsEmpty(message: "Введите корректный логин и пароль")
            router.showAlert(alert: alert)
        }
    }
}
