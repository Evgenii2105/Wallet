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
        
        let userStorage: UserStorage = UserStorageImpl()
        let state: RootContainerPresenterImpl.State = userStorage.isUserLoggedIn ? .loggedIn : .loggedOut
        window?.rootViewController = RootContainerBuilder.build(
            userStorage: userStorage,
            state: state
        )
        
        window?.makeKeyAndVisible()
    }
}
