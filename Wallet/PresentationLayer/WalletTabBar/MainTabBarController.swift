//
//  MainTabBarController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 03.07.2025.
//

import UIKit

protocol TabBarConfiguration {
    var tabImage: UIImage? { get }
}

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let walletList = WalletListBuilder.build()
        let walletNavigation = UINavigationController(rootViewController: walletList)
        walletNavigation.tabBarItem = createTabItem(for: walletList, index: 0)
        
        let placeholderViewOne = PlaceholderScreenViewController()
        placeholderViewOne.tabBarItem = createTabItem(for: placeholderViewOne, index: 1)
        
        let placeholderViewTwo = PlaceholderScreenViewController()
        placeholderViewTwo.tabBarItem = createTabItem(for: placeholderViewTwo, index: 2)
        
        let placeholderViewThree = PlaceholderScreenViewController()
        placeholderViewThree.tabBarItem = createTabItem(for: placeholderViewThree, index: 3)
        
        let placeholderViewFour = PlaceholderScreenViewController()
        placeholderViewFour.tabBarItem = createTabItem(for: placeholderViewFour, index: 4)
        
        viewControllers = [walletNavigation, placeholderViewOne, placeholderViewTwo, placeholderViewThree, placeholderViewFour]
    }
    
    private func createTabItem(for controller: TabBarConfiguration, index: Int) -> UITabBarItem {
        let image: UIImage?
        
        switch index {
        case 0:
            image = UIImage(systemName: "house")
        case 1:
            image = UIImage(systemName: "arrow.up.forward")
        case 2:
            image = UIImage(systemName: "creditcard")
        case 3:
            image = UIImage(systemName: "newspaper")
        case 4:
            image = UIImage(systemName: "person")
        default:
            image = nil
        }
        
        return UITabBarItem(
            title: nil,
            image: image,
            selectedImage: nil
        )
    }
}
