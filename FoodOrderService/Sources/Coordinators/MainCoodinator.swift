//
//  AppCoordinator.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 13.06.2023.
//

import UIKit

class MainCoodinator: Coordinator {
    var flowComplitionHandler: CoodinatorHandler?
    var navigationController: UINavigationController
    private let moduleFactory = ModulFactory()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainScene(index: IndexPath())
    }
    
    private func showMainScene(index: IndexPath) {
        let controller = moduleFactory.createMainView()
        
        controller.goToCollection = { [weak self] section in
            if section == .category {
                controller.goToDishCategory = { [weak self] cat in
                    self?.showDishlistScene(dishCategory: cat)
                }
            } else {
                controller.goToDetail = { [weak self] dishs in
                    self?.showDetailScene(dishs: dishs)
                }
            }
        }
        controller.goToNextScreen = { [weak self] in
            self?.showOrderlistScene()
        }
        
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .curveEaseInOut]
        UIView.transition(with: navigationController.view,
                          duration: 0.5,
                          options: transitionOptions,
                          animations: nil,
                          completion: nil)
        
        navigationController.pushViewController(controller, animated: false)
    }

    private func showDetailScene(dishs: Dish?) {
        let controller = moduleFactory.createDetailView()
        controller.dish = dishs

        let detailNavigationController = UINavigationController(rootViewController: controller)
        if let sheet = detailNavigationController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        navigationController.present(detailNavigationController, animated: true)
    }

    private func showDishlistScene(dishCategory: DishCategory) {
        let controller = moduleFactory.createDishlistView()
        controller.goToDetail = { [weak self] dishDetail in
            self?.showDetailScene(dishs: dishDetail)
        }

        controller.category = dishCategory
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func showOrderlistScene() {
        let controller = moduleFactory.createOrderView()
        controller.goToNextScreen = { [weak self] in
            self?.showDetailScene(dishs: nil)
        }
        navigationController.pushViewController(controller, animated: true)
    }
}
