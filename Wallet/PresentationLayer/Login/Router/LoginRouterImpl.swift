//
//  LoginRouterImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class LoginRouterImpl: LoginRouter {
    
    weak var viewController: UIViewController?
    
    func showAlert(alert: AlertContentPresentable) {
        viewController?.present(alert.alert, animated: alert.isAnimated)
    }
}
