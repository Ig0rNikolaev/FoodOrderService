//
//  DishlistViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 28.06.2023.
//

import UIKit

protocol DishlistViewModelProtocol {
    func transitionDetail(complitionHandler: SceneNavigation?)
}

class DishlistViewModel: DishlistViewModelProtocol {
    func transitionDetail(complitionHandler: SceneNavigation?) {
        complitionHandler?()
    }
}
