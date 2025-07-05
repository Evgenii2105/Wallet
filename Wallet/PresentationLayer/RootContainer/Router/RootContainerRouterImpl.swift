//
//  RootContainerRouterImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class RootContainerRouterImpl: RootContainerRouter {
   
    weak var viewController: UIViewController?
    private weak var loginViewController: UIViewController?
    
    func showLoginScreen(with listener: LoginListener) {
        let loginViewController = LoginModuleBuilder.build(with: listener)
        self.loginViewController = loginViewController
        viewController?.addChildViewController(loginViewController)
    }
    
    func showWalletTabBar() {
        viewController?.addChildViewController(MainTabBarController())
    }
    
    func replaceLoginWithWallet() {
        guard let childViewController = loginViewController else { return }
        viewController?.removeChildViewController(childViewController)
        showWalletTabBar()
    }
}
