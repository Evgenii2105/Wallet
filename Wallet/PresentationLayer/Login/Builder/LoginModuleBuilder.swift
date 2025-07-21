//
//  Untitled.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//


import UIKit

final class LoginModuleBuilder {
    
    static func build(with listener: LoginListener) -> UIViewController {
        let view = LoginViewController()
        let router = LoginRouterImpl()
        let alert = AlertFactoryServiceImpl()
        let interactor = LoginInteractorImpl(
            router: router,
            alertFactory: alert
        )
        let presenter = LoginPresenterImpl(
            view: view,
            interactor: interactor
        )
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.router = router
        router.viewController = view
        presenter.view = view
        interactor.listener = listener
        
        return view
    }
}
