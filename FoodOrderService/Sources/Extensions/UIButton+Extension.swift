//
//  UIButton+Extension.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 21.06.2023.
//

import UIKit

extension UIButton {
    func shadowButton() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
}
