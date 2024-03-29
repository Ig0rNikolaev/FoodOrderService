//
//  Route.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 11.07.2023.
//

import Foundation

enum Route {
    static let baseURL = "https://yummie.glitch.me"
    
    case allCategorise
    case placeOrder(String)
    case fetchCategoryDishes(String)
    case fetchOrder
    
    var description: String {
        switch self {
        case .allCategorise:
            return "/dish-categories"
        case .placeOrder(let dishId):
            return "/orders/\(dishId)"
        case .fetchCategoryDishes(let categoryId):
            return "/dishes/\(categoryId)"
        case .fetchOrder:
            return "/orders/"
        }
    }
}
