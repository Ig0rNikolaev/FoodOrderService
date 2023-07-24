//
//  SceneController.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 14.06.2023.
//

import UIKit

typealias SceneController = DetailController & CollectionController & OrderController
typealias SceneNavigation = () -> ()

protocol FlowController {
    var goToNextScreen: SceneNavigation? { get set }
}

protocol CollectionController {
    var goToCollection: ((SectionName) -> ())? { get set }
    var goToDishCategory: ((DishCategory) -> ())? { get set }
}

protocol DetailController {
    var goToDetail: ((Dish?) -> ())? { get set }
}

protocol OrderController {
    var goToOrder: ((Order?) -> ())? { get set }
}
