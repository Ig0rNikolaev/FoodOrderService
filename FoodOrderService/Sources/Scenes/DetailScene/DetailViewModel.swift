//
//  DetailViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 19.07.2023.
//

import UIKit
import ProgressHUD
import IQKeyboardManagerSwift

fileprivate enum DetailConstantsVM {

    //: MARK: - StringConstants

    static let progressShow = "Заказ добавляется..."
    static let progressShowSucceed = "Заказ добавлен в корзину."
    static let alertTitle = "Ошибка"
    static let alertButton = "OK"
    static let alertMessage = "Введите Ваше имя"
    static let scheme = "https"
    static let host = "yummie.glitch.me"
}

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
        let url = networkService?.createURL(scheme: DetailConstantsVM.scheme, host: DetailConstantsVM.host, path: .placeOrder(dishID))
        let params = ["name": name]
        networkService?.reqest(url: url, method: .post, parametrs: params, completion: completion)
    }

    func tabButton(textDetail: UITextField, showAlert: () -> Void, dish: Dish?) {
        guard let name = textDetail.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else { return showAlert() }
        ProgressHUD.colorAnimation = .systemGreen
        ProgressHUD.show(DetailConstantsVM.progressShow)
        placeOrder(dishID: dish?.id ?? "", name: name) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    ProgressHUD.showSucceed(DetailConstantsVM.progressShowSucceed)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func createAlert(viewController: UIViewController) {
        let alert = UIAlertController(title: DetailConstantsVM.alertTitle, message: DetailConstantsVM.alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: DetailConstantsVM.alertButton, style: .cancel))
        viewController.present(alert, animated: true, completion: nil)
    }

    func createKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
