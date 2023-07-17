//
//  AllDishes.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 10/06/2021.
//

import Foundation

struct AllDishes: Decodable {
    var categories: [DishCategory]?
    var populars: [Dish]?
    var specials: [Dish]?
}

struct DishCategory: Decodable {
    var id, name, image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}

struct Dish: Decodable {
    var id, name, description, image: String?
    var calories: Int?

    var formattedCalories: String {
        return "\(calories ?? 0) calories"
    }
}

struct Order: Decodable {
    var id: String?
    var name: String?
    var dish: Dish?
}
