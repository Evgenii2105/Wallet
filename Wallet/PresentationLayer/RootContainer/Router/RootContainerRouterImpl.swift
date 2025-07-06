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
    private weak var tabBarController: UIViewController?
    
    func showLoginScreen(with listener: LoginListener) {
        let loginViewController = LoginModuleBuilder.build(with: listener)
        self.loginViewController = loginViewController
        viewController?.addChildViewController(loginViewController)
    }
    
    func showWalletTabBar(with listener: WalletListListener) {
        let walletTabBarController = MainTabBarController(walletListListener: listener)
        self.tabBarController = walletTabBarController
        viewController?.addChildViewController(walletTabBarController)
    }
    
    func replaceLoginWithWallet(with listener: WalletListListener) {
        guard let childViewController = loginViewController else { return }
        viewController?.removeChildViewController(childViewController)
        showWalletTabBar(with: listener)
    }
    
    func replaceWalletWithLogin(with listener: LoginListener) {
        guard let childViewController = tabBarController else { return }
        viewController?.removeChildViewController(childViewController)
        showLoginScreen(with: listener)
    }
}
