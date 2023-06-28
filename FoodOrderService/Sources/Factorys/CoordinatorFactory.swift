//
//  CoordinatorFactory.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 13.06.2023.
//

import UIKit

class CoordinatorFactory {
    static func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        AppCoordinator(navigationController: navigationController)
    }

    static func createMainCoordinator(navigationController: UINavigationController) -> MainCoodinator {
        MainCoodinator(navigationController: navigationController)
    }

    static func createOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinator {
        OnboardingCoordinator(navigationController: navigationController)
    }
}
