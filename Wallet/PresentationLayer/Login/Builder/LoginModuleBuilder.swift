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
        let router = LoginRouterimpl()
        let alert = AlertFactoryServiceImpl()
        let interactor = LoginInteractorimpl(
            router: router,
            alertFactory: alert
        )
        let presenter = LoginPresenterimpl(
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
