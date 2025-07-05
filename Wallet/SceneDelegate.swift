//
//  SceneDelegate.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        let state: RootContainerPresenterImpl.State = UserStorageImpl.sharedInstance.isUserLoggedIn ? .loggedIn : .loggedOut
        window?.rootViewController = RootContainerBuilder.build(state: state)
        
        window?.makeKeyAndVisible()
    }
}
