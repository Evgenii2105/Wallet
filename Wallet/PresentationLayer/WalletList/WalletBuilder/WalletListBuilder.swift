//
//  WalletListBuilder.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListBuilder {
    
    static func build() -> WalletListViewController {
        let view = WalletListViewController()
        let router = WalletListRouterimpl()
        let interactor = WalletListInteractorimpl(router: router)
        let presenter = WalletListPresenterimpl(
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
