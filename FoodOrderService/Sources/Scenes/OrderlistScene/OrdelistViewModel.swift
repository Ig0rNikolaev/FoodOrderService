//
//  OrdelistViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 28.06.2023.
//

import UIKit

protocol OrderlistViewModelProtocol {
    func transitionDetail(complitionHandler: SceneNavigation?)
    func transitionDetail(complitionHandler: ((Order?) -> ())?, array: Order?)
    func fetchOrders(completion: @escaping(Result<[Order], NetworkError>) -> Void)
}

class OrderlistViewModel: OrderlistViewModelProtocol {
    private let networkService: NetworkServiceProtocol?
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }

    func transitionDetail(complitionHandler: SceneNavigation?) {
        complitionHandler?()
    }

    func transitionDetail(complitionHandler: ((Order?) -> ())?, array: Order?) {
        complitionHandler?(array)
    }

    func fetchOrders(completion: @escaping(Result<[Order], NetworkError>) -> Void) {
        let url = networkService?.createURL(scheme: "https", host: "yummie.glitch.me", path: .fetchOrder)
        networkService?.reqest(url: url, method: .get, parametrs: nil, completion: completion)
    }
}
