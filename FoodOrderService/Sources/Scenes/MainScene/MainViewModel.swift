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
    func transitionSection(complitionHandler: ((SectionName) -> ())?, index: SectionName?)
    func transitionDetail(complitionHandler: ((Dish?) -> ())?, array: Dish?)
    func transitionOrder(complitionHandler: SceneNavigation?)
    func transitionCategory(complitionHandler: ((DishCategory) -> ())?, array: DishCategory?)
    func transitionOrder(complitionHandler: ((Order?) -> ())?)
    func fetchAllDishes(completion: @escaping(Result<AllDishes, NetworkError>) -> Void)
}

class MainViewModel: MainViewModelProtocol {
    private let networkService: NetworkServiceProtocol?
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }

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

    func transitionSection(complitionHandler: ((SectionName) -> ())?, index: SectionName?) {
        complitionHandler?(index ?? .category)
    }

    func transitionDetail(complitionHandler: ((Dish?) -> ())?, array: Dish?) {
        complitionHandler?(array)
    }

    func transitionOrder(complitionHandler: ((Order?) -> ())?) {
        complitionHandler?(Order())
    }

    func transitionCategory(complitionHandler: ((DishCategory) -> ())?, array: DishCategory?) {
        complitionHandler?(array ?? DishCategory())
    }

    func transitionOrder(complitionHandler: SceneNavigation?) {
        complitionHandler?()
    }

    func fetchAllDishes(completion: @escaping(Result<AllDishes, NetworkError>) -> Void) {
        guard let url = networkService?.createURL(scheme: "https", host: "yummie.glitch.me", path: .allCategorise) else { return  }
        networkService?.reqest(url: url, method: .get, parametrs: nil, completion: completion)
    }
}
