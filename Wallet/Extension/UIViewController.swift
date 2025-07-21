//
//  Extention.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

extension UIViewController {
    
    func addChildViewController(_ childViewController: UIViewController) {
        guard childViewController.parent == nil else { return }
        
        addChild(childViewController)
        view.addSubviewAndFill(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    func removeChildViewController(_ childViewController: UIViewController) {
        guard childViewController.parent == self else { return }
        
        childViewController.willMove(toParent: nil)
        childViewController.view.removeConstraints(childViewController.view.constraints)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
}
