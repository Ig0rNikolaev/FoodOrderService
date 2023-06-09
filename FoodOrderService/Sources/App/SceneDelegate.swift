//
//  SceneDelegate.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 02.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        appCoordinator = CoordinatorFactory.createAppCoordinator(navigationController: UINavigationController())
        window?.rootViewController = appCoordinator?.navigationController
        appCoordinator?.start()
        window?.makeKeyAndVisible()
    }
}

