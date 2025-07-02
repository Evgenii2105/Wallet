//
//  UIView.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

extension UIView {
    
    enum ViewError: Error {
        case viewWasNotAddedToHierache
    }
    
    func addSubviewAndFill(_ view: UIView) {
        do {
            addSubview(view)
            try view.fillToSuperview()
        }
        catch {
            print(error)
        }
    }
    
    func fillToSuperview() throws {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview else {
            throw ViewError.viewWasNotAddedToHierache
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
}
