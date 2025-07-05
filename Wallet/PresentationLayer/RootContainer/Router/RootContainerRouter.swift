//
//  RootContainerRouter.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol RootContainerRouter: AnyObject {
    func showLoginScreen(with listener: LoginListener)
    func showWalletTabBar()
    func replaceLoginWithWallet()
}
