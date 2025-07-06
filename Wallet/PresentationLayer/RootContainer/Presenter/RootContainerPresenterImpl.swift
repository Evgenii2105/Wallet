//
//  RootContainerPresenterImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

final class RootContainerPresenterImpl: RootContainerPresenter {
    
    enum State {
        case loggedIn
        case loggedOut
    }
    
    weak var view: RootContainerView?
    private let router: RootContainerRouter
    private let state: State
    
    init(state: State, view: RootContainerView, router: RootContainerRouter) {
        self.state = state
        self.view = view
        self.router = router
    }
    
    func showScreen() {
        switch state {
        case .loggedIn:
            router.showWalletTabBar(with: self)
        case .loggedOut:
            router.showLoginScreen(with: self)
        }
    }
}

extension RootContainerPresenterImpl: LoginListener {
    
    func didLogin() {
        router.replaceLoginWithWallet(with: self)
    }
}

extension RootContainerPresenterImpl: WalletListListener {
    
    func needsToLogout() {
        router.replaceWalletWithLogin(with: self)
    }
}
