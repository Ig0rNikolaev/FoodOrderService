//
//  OnboardingCoordinator.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 27.06.2023.
//

import Foundation
import UIKit

class OnboardingCoordinator: Coordinator {
    var flowComplitionHandler: CoodinatorHandler?
    var navigationController: UINavigationController
    let moduleFactory = ModulFactory()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showOnboardingScene()
    }

    private func showOnboardingScene() {
        let controller = moduleFactory.createOnboardingView()
        controller.goToNextScreen = { [weak self] in
            self?.flowComplitionHandler?()
        }
        navigationController.pushViewController(controller, animated: true)
    }
}
