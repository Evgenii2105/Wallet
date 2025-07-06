//
//  LoginPresenterImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

final class LoginPresenterImpl: LoginPresenter {
   
    weak var view: LoginView?
    private let interactor: LoginInteractor
    
    init(view: LoginView, interactor: LoginInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func handleAuth(login: String?, password: String?) {
        interactor.handleAuth(login: login, password: password)
    }
}

extension LoginPresenterImpl: LoginPresenterOutput {
    func clearTextField() {
        view?.clearTextField()
    }
}
