//
//  MainModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 15.06.2023.
//

import UIKit

struct MainTopModel {
    let description: String?
    let view: UIImage?
}

enum SectionName: Int {
    case top
    case category
    case popular
    case cheff
}
