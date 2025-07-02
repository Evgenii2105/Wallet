//
//  LoginRouterimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class LoginRouterimpl: LoginRouter {
    
    weak var viewController: UIViewController?
    
    func openWallet() {
        let view = WalletListViewController()
        let router = WalletListRouterimpl()
        let interactor = WalletListInteractorimpl(router: router)
        let presenter = WalletListPresenterimpl(
            view: view,
            interactor: interactor
        )
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        interactor.router = router
        router.viewController = view
        
        viewController?.addChildViewController(view)
    }
    
    func showAlert(alert: AlertContentPresentable) {
        viewController?.present(alert.alert, animated: alert.isAnimated)
    }
}
