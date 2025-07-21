//
//  WalletListPresenterImpl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListPresenterImpl: WalletListPresenter {

    weak var view: WalletListView?
    private let interactor: WalletListInteractor
        
    init(view: WalletListViewController, interactor: WalletListInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func setupDataSource() {
        interactor.setupDataSource()
    }
    
    func didLogout() {
        interactor.didLogout()
    }
    
    func refreshTable() {
        interactor.setupDataSource()
    }
    
    func sortedHeader(by sort: WalletListInteractorImpl.CoinsSorting) {
        interactor.sortedHeader(by: sort)
    }
    
    func showDetailsCoin(coin: WalletListItem) {
        interactor.showDetailsCoin(item: coin)
    }
    
    func getHeaderMenu() -> UIMenu {
        let actions: [UIAction] = WalletListInteractorImpl.CoinsSorting.allCases.map({ sort in
            let action = UIAction(
                title: sort.title,
                state: interactor.getSortState(sort: sort)) { [weak self] _ in
                    self?.interactor.getSortAction(sort: sort)()
                }
            return action
        })
        return UIMenu(children: actions)
    }
}

extension WalletListPresenterImpl: WalletListPresenterOutput {
    
    func hideLoadingIndicator() {
        view?.hideLoadingIndicator()
    }
    
    func reconfigureMenu() {
        view?.reconfigureHeader()
    }
    
    func didGet(walletListItems: [WalletListItem]) {
        view?.didGet(walletListItems: walletListItems)
    }
    
    func showLoadingIndicator() {
        view?.showLoadingIndicator()
    }
}
