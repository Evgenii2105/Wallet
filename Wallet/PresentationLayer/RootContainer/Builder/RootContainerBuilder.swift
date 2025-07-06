//
//  RootContainerBuilder.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class RootContainerBuilder {
    
    static func build(userStorage: UserStorage, state: RootContainerPresenterImpl.State) -> UIViewController {
        let view = RootContainerViewController()
        let router = RootContainerRouterImpl(userStorage: userStorage)
        let presenter = RootContainerPresenterImpl(
            state: state,
            view: view,
            router: router
        )
        view.presenter = presenter
        presenter.view = view
        router.viewController = view
        
        return view
    }
}
