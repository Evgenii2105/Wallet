//
//  RootContainerRouterImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class RootContainerRouterImpl: RootContainerRouter {
    
    weak var viewController: UIViewController?
    
    func showLoginScreen() {
        let view = LoginViewController()
        let router = LoginRouterimpl()
        let alert = makeAlert()
        let interactor = LoginInteractorimpl(
            router: router, alertFactory: alert
        
        )
        let presenter = LoginPresenterimpl(
            view: view,
            interactor: interactor
        )
        view.presenter = presenter
        presenter.view = view
        interactor.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        viewController?.addChildViewController(view)
    }
    
    func showWalletTabBar() {
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
}
