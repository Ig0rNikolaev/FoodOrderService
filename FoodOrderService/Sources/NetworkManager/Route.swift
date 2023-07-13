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
    
    var description: String {
        switch self {
        case .allCategorise:
            return "/dish-categories"
        }
    }
}
