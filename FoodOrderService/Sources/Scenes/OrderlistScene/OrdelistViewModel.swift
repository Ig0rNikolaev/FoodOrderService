//
//  OrdelistViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 28.06.2023.
//

import UIKit

protocol OrderlistViewModelProtocol {
    func transitionDetail(complitionHandler: SceneNavigation?)
    func transitionDetail(complitionHandler: ((Order?) -> ())?, array: Order?)
}

class OrderlistViewModel: OrderlistViewModelProtocol {
    func transitionDetail(complitionHandler: SceneNavigation?) {
        complitionHandler?()
    }

    func transitionDetail(complitionHandler: ((Order?) -> ())?, array: Order?) {
        complitionHandler?(array)
    }
}
