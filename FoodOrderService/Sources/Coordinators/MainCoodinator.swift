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
    var index: SectionName?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainScene()
    }
    
    private func showMainScene() {
        let controller = moduleFactory.createMainView()
        controller.goToCollection = { [weak self] section in
            section == .category ? self?.showDishlistScene() : self?.showDetailScene()
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
    
    private func showDetailScene() {
        let controller = moduleFactory.createDetailView()
        let detailNavigationController = UINavigationController(rootViewController: controller)
        if let sheet = detailNavigationController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        navigationController.present(detailNavigationController, animated: true)
    }
    
    private func showDishlistScene() {
        let controller = moduleFactory.createDishlistView()
        controller.goToNextScreen = { [weak self] in
            self?.showDetailScene()
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func showOrderlistScene() {
        let controller = moduleFactory.createOrderView()
        controller.goToNextScreen = { [weak self] in
            self?.showDetailScene()
        }
        navigationController.pushViewController(controller, animated: true)
    }
}
