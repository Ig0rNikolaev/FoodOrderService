//
//  DetailViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 19.07.2023.
//

import Foundation
import UIKit
import ProgressHUD
import IQKeyboardManagerSwift

protocol DetailViewModelProtocol: AnyObject {
    func tabButton(textDetail: UITextField, showAlert: () -> Void, dish: Dish?)
    func createAlert(viewController: UIViewController)
    func createKeyboard()
    func placeOrder(dishID: String, name: String, completion: @escaping(Result<Order, NetworkError>) -> Void)
}

class DetailViewModel: DetailViewModelProtocol {
    private let networkService: NetworkServiceProtocol?
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }

    func placeOrder(dishID: String, name: String, completion: @escaping(Result<Order, NetworkError>) -> Void) {
        let url = networkService?.createURL(scheme: "https", host: "yummie.glitch.me", path: .placeOrder(dishID))
        let params = ["name": name]
        networkService?.reqest(url: url, method: .post, parametrs: params, completion: completion)
    }

    func tabButton(textDetail: UITextField, showAlert: () -> Void, dish: Dish?) {
        guard let name = textDetail.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else { return showAlert() }
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.show("Заказ добавляется...")
        placeOrder(dishID: dish?.id ?? "", name: name) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    ProgressHUD.showSucceed("Заказ добавлен в корзину.")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func createAlert(viewController: UIViewController) {
        let alert = UIAlertController(title: "Ошибка", message: "Введите Ваше имя", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController.present(alert, animated: true, completion: nil)
    }

    func createKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
