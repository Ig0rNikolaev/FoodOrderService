//
//  MainViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 14.06.2023.
//

import UIKit

fileprivate enum MainConstantsVM {

    //: MARK: - StringConstants

    static let topDescriptionOne = "Рестораны"
    static let topViewOne = "ресторан"
    static let topDescriptionTwo = "Продукты"
    static let topViewTwo = "продукты"
    static let topDescriptionThree = "Доставка"
    static let topViewThree = "доставка"
}

protocol MainViewModelProtocol: AnyObject {
    var topCategory: [MainTopModel] { get set }
    func fetchAllDishes(completion: @escaping(Result<AllDishes, NetworkError>) -> Void)
    func setupCellView(imageCell: UIImageView, labelCellDescription: UILabel, index: Int)
    func configureTopCell(cell: MainTopCell, index: Int)

    func transitionSection(complitionHandler: ((SectionName) -> ())?, index: SectionName?)
    func transitionDetail(complitionHandler: ((Dish?) -> ())?, array: Dish?)
    func transitionCategory(complitionHandler: ((DishCategory) -> ())?, array: DishCategory?)
    func transitionOrder(complitionHandler: ((Order?) -> ())?)
}

class MainViewModel: MainViewModelProtocol {
    private let networkService: NetworkServiceProtocol?
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }

    var topCategory: [MainTopModel] = [MainTopModel(description: MainConstantsVM.topDescriptionOne,
                                                    view: UIImage(named: MainConstantsVM.topViewOne)),
                                       MainTopModel(description: MainConstantsVM.topDescriptionTwo,
                                                    view: UIImage(named: MainConstantsVM.topViewTwo)),
                                       MainTopModel(description: MainConstantsVM.topDescriptionThree,
                                                    view: UIImage(named: MainConstantsVM.topViewThree))
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

    func fetchAllDishes(completion: @escaping(Result<AllDishes, NetworkError>) -> Void) {
        guard let url = networkService?.createURL(scheme: "https", host: "yummie.glitch.me", path: .allCategorise) else { return  }
        networkService?.reqest(url: url, method: .get, parametrs: nil, completion: completion)
    }
}
