//
//  RootContainerViewController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class RootContainerViewController: UIViewController {
    
    var presenter: RootContainerPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.showScreen()
    }
}

extension RootContainerViewController: RootContainerView {
}
