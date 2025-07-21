//
//  AlertContentPresentable.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

protocol AlertActionHandler: AnyObject {
    func handleActions()
}

protocol AlertContentPresentable {
    var alert: UIViewController { get }
    var isAnimated: Bool { get }
}

protocol AlertFactoryService: AnyObject {
    func failureLoginIsEmpty(message: String, handler: AlertActionHandler) -> AlertContentPresentable
    func showNetworkError(
        message: String,
        cancelHandler: @escaping () -> Void,
        repeatHandler: @escaping () -> Void,
    ) -> AlertContentPresentable
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
                handler.handleActions()
            })
        )
        alert.addAction(UIAlertAction(title: "Повторить", style: .cancel))
        
        return AlertContent(
            alert: alert,
            isAnimated: true
        )
    }
    
    func showNetworkError(
        message: String,
        cancelHandler: @escaping () -> Void,
        repeatHandler: @escaping () -> Void
    ) -> AlertContentPresentable {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Отсутвует подключение к интернету",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "Отменить",
            style: .cancel,
            handler: { _ in
                cancelHandler()
            })
        )
        
        alert.addAction(UIAlertAction(
            title: "Повторить",
            style: .default,
            handler: { _ in
                repeatHandler()
            })
        )
        
        return AlertContent(
            alert: alert,
            isAnimated: true
        )
    }
}
