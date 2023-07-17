//
//  SceneController.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 14.06.2023.
//

import UIKit

typealias SceneNavigation = () -> ()

protocol FlowController {
    var goToNextScreen: SceneNavigation? { get set }
}

protocol CollectionController {
    associatedtype T
    var goToCollection: ((T) -> ())? { get set }
}

protocol DetailController {
    associatedtype Detail
    var goToDetail: ((Detail) -> ())? { get set }
}
