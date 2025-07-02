//
//  AlertContentPresentable.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

protocol AlertContentPresentable {
    var alert: UIViewController { get }
    var isAnimated: Bool { get }
}

struct AlertContent: AlertContentPresentable {
    var alert: UIViewController
    
    var isAnimated: Bool
}

protocol AlertFactoryService: AnyObject {
    func failureLoginIsEmpty(message: String) -> AlertContentPresentable
}

final class makeAlert: AlertFactoryService {
    func failureLoginIsEmpty(message: String) -> AlertContentPresentable {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Введите правильный логин и пароль",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return AlertContent(
            alert: alert,
            isAnimated: true
        )
    }
}
