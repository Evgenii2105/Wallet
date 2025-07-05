//
//  WalletListRouterimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListRouterimpl: WalletListRouter {
    
    weak var viewController: UIViewController?
    
    func didLogout() {
        
    }
    
    func showDetailsCoin(coin: WalletListItem) {
        let view = CoinDetailsViewController()
        let router = CoinDetailsRouterimpl()
        let interactor = CoinDetailsInteractorimpl(router: router)
        let presenter = CoinDetailsPresenterimpl(
            view: view,
            interactor: interactor
        )
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.viewController = view
        
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
