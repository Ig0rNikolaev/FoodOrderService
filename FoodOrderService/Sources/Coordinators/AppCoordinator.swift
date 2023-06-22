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
        controller.goToNextScreen = { [weak self] in
            self?.showDetailScene()
        }
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .curveEaseInOut]
        UIView.transition(with: navigationController.view,
                          duration: 0.5,
                          options: transitionOptions,
                          animations: nil,
                          completion: nil)
        
        navigationController.pushViewController(controller, animated: false)
    }

    private func showDetailScene() {
        let controller = moduleFactory.createDetailView()
        let detailNavigationController = UINavigationController(rootViewController: controller)
        if let sheet = detailNavigationController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        navigationController.present(detailNavigationController, animated: true)
    }
}
