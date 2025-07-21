//
//  WalletListBuilder.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListBuilder {
    
    static func build(userStorage: UserStorage, listener: WalletListListener?) -> WalletListViewController {
        let view = WalletListViewController()
        let router = WalletListRouterImpl()
        let interactor = WalletListInteractorImpl(
            userStorage: userStorage,
            alertFactory: AlertFactoryServiceImpl(),
            router: router,
            listener: listener
        )
        let presenter = WalletListPresenterImpl(
            view: view,
            interactor: interactor
        )
        view.presenter = presenter
        presenter.view = view
        router.viewController = view
        interactor.presenter = presenter
        
        return view
    }
}
