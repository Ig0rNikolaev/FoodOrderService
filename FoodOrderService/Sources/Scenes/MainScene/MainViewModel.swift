//
//  MainViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 14.06.2023.
//

import UIKit

protocol MainViewModelProtocol: AnyObject {
    var topCategory: [MainTopModel] { get set }
    func setupCellView(imageCell: UIImageView, labelCellDescription: UILabel, index: Int)
    func configureTopCell(cell: MainTopCell, index: Int)
    func transitionDetail(complitionHandler: ((SectionName) -> ())?, index: SectionName?)
    func transitionOrder(complitionHandler: SceneNavigation?)
}

class MainViewModel: MainViewModelProtocol {
    var topCategory: [MainTopModel] = [MainTopModel(description: "Рестораны", view: UIImage(named: "ресторан")),
                                       MainTopModel(description: "Продукты", view: UIImage(named: "продукты")),
                                       MainTopModel(description: "Доставка", view: UIImage(named: "доставка"))
    ]

    func setupCellView(imageCell: UIImageView, labelCellDescription: UILabel, index: Int) {
        imageCell.image = topCategory[index].view
        labelCellDescription.text = topCategory[index].description
    }


    func configureTopCell(cell: MainTopCell, index: Int) {
        cell.setupTopCell(index: index)
    }

    func transitionDetail(complitionHandler: ((SectionName) -> ())?, index: SectionName?) {
        complitionHandler?(index ?? .category)
    }

    func transitionOrder(complitionHandler: SceneNavigation?) {
        complitionHandler?()
    }
}
