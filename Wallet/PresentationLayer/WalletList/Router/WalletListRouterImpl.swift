//
//  WalletListRouterimpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListRouterImpl: WalletListRouter {

    weak var viewController: UIViewController?
    
    func showDetailsCoin(coin: CoinData) {
        let view = CoinDetailsViewController()
        let router = CoinDetailsRouterImpl()
        let interactor = CoinDetailsInteractorImpl(
            coin: coin,
            router: router)
        let presenter = CoinDetailsPresenterImpl(
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
