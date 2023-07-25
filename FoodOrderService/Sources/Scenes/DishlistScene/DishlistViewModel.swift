//
//  DishlistViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 28.06.2023.
//

import UIKit

fileprivate enum DishlistConstantsVM {

    //: MARK: - StringConstants

    static let scheme = "https"
    static let host = "yummie.glitch.me"
}

protocol DishlistViewModelProtocol {
    func transitionDetail(complitionHandler: SceneNavigation?)
    func transitionDetail(complitionHandler: ((Dish?) -> ())?, array: Dish?)
    func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Dish], NetworkError>) -> Void)
}

class DishlistViewModel: DishlistViewModelProtocol {
    private let networkService: NetworkServiceProtocol?
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }

    func transitionDetail(complitionHandler: SceneNavigation?) {
        complitionHandler?()
    }

    func transitionDetail(complitionHandler: ((Dish?) -> ())?, array: Dish?) {
        complitionHandler?(array)
    }

    func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Dish], NetworkError>) -> Void) {
        let url = networkService?.createURL(scheme: DishlistConstantsVM.scheme, host: DishlistConstantsVM.host, path: .fetchCategoryDishes(categoryId))
        networkService?.reqest(url: url, method: .get, parametrs: nil, completion: completion)
    }
}
