//
//  OrdelistViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 28.06.2023.
//

import UIKit

protocol OrderlistViewModelProtocol {
    func transitionDetail(complitionHandler: SceneNavigation?)
}

class OrderlistViewModel: OrderlistViewModelProtocol {
    func transitionDetail(complitionHandler: SceneNavigation?) {
        complitionHandler?()
    }
}
