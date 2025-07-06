//
//  AlertContentPresentable.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

protocol AlertActionHandler: AnyObject {
    func handleAlertCancelAction()
}

protocol AlertContentPresentable {
    var alert: UIViewController { get }
    var isAnimated: Bool { get }
}

protocol AlertFactoryService: AnyObject {
    func failureLoginIsEmpty(message: String, handler: AlertActionHandler) -> AlertContentPresentable
}

struct AlertContent: AlertContentPresentable {
    
    var alert: UIViewController
    var isAnimated: Bool
}

final class AlertFactoryServiceImpl: AlertFactoryService {
    
    func failureLoginIsEmpty(message: String, handler: AlertActionHandler) -> AlertContentPresentable {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Введите правильный логин и пароль",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "Отменить",
            style: .destructive,
            handler: { _ in
                handler.handleAlertCancelAction()
            })
        )
        alert.addAction(UIAlertAction(title: "Повторить", style: .cancel))
        
        return AlertContent(
            alert: alert,
            isAnimated: true
        )
    }
}
