//
//  AppCoordinator.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 27.06.2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var flowComplitionHandler: CoodinatorHandler?
    var navigationController: UINavigationController
    let moduleFactory = ModulFactory()
    private var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showOnboardingFlow()
    }

    private func showOnboardingFlow() {
        let onboardingCoordinator = CoordinatorFactory.createOnboardingCoordinator(navigationController: navigationController)
        childCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.flowComplitionHandler = { [weak self] in
            self?.showMainFlow()
        }
        onboardingCoordinator.start()
     }

    private func showMainFlow() {
        let mainCoordinator = CoordinatorFactory.createMainCoordinator(navigationController: navigationController)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.flowComplitionHandler = { [weak self] in
            self?.flowComplitionHandler?()
        }
        mainCoordinator.start()
     }
}
