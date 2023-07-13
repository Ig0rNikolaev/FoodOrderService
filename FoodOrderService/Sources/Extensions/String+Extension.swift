//
//  String+Extension.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 11.07.2023.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
