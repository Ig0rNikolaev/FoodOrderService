//
//  Coordinator.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 14.06.2023.
//

import UIKit

typealias CoodinatorHandler = () -> ()

protocol Coordinator: AnyObject {
    var flowComplitionHandler: CoodinatorHandler? { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
