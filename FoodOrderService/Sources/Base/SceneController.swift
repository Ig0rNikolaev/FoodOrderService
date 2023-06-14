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
