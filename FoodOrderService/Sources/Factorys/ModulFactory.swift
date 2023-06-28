//
//  ModulFactory.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 13.06.2023.
//

import UIKit

class ModulFactory {
    func createOnboardingView() -> OnboardingView {
        OnboardingView()
    }

    func createMainView() -> MainView {
        MainView()
    }

    func createDetailView() -> DetailView {
        DetailView()
    }

    func createDishlistView() -> DishlistView {
        DishlistView()
    }

    func createOrderView() -> OrderlistView {
        OrderlistView()
    }
}
