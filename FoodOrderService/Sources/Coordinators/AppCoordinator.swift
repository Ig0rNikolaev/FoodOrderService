//
//  AppCoordinator.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 13.06.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let moduleFactory = ModulFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showOnboardingScene()
    }
    
    private func showOnboardingScene() {
        let controller = moduleFactory.createOnboardingView()
        controller.goToNextScreen = { [weak self] in
            self?.showMainScene()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    private func showMainScene() {
        let controller = moduleFactory.createMainView()
        navigationController.pushViewController(controller, animated: true)
    }
}
