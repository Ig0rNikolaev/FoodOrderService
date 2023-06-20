//
//  CollectionCell+Extension.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 16.06.2023.
//

import UIKit

extension UICollectionViewCell {
    func shadow(cell: UICollectionViewCell) {
        cell.layer.cornerRadius = 10
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true

        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.shadowColor = UIColor.systemGray3.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    }
}
