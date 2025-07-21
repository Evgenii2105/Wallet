//
//  RootContainerRouter.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import Foundation

protocol RootContainerRouter: AnyObject {
    func showLoginScreen(with listener: LoginListener)
    func showWalletTabBar(with listener: WalletListListener)
    func replaceLoginWithWallet(with listener: WalletListListener)
    func replaceWalletWithLogin(with listener: LoginListener)
}
