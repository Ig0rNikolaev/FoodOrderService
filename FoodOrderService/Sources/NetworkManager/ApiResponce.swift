//
//  ApiResponce.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 12.07.2023.
//

import Foundation

struct ApiResponce<T: Decodable>: Decodable {
    let status: Int
    let messege: String?
    let data: T?
    let error: String?
}
