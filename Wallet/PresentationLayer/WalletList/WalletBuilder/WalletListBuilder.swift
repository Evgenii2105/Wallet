//
//  WalletListBuilder.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListBuilder {
    
    static func build(listener: WalletListListener?) -> WalletListViewController {
        let view = WalletListViewController()
        let router = WalletListRouterImpl()
        let interactor = WalletListInteractorImpl(
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
        interactor.router = router
        
        return view
    }
}
