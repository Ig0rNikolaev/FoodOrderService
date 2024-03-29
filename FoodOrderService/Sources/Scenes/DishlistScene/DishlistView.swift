//
//  DishlistView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 26.06.2023.
//

import UIKit
import ProgressHUD

fileprivate enum DishlistConstants {

    //: MARK: - StringConstants

    static let header = "CПИСОК БЛЮД"
}

class DishlistView: UIViewController, DetailController {
    var dishlistViewModel: DishlistViewModelProtocol?
    var goToDetail: ((Dish?) -> ())?
    var category: DishCategory?
    var dishes: [Dish] = []

    //: MARK: - UI Elements

    private lazy var dishlist: UITableView = {
        let dishlist = UITableView(frame: .zero, style: .plain)
        dishlist.register(DishOrderCell.self, forCellReuseIdentifier: DishOrderCell.identifier)
        dishlist.register(Header.self, forHeaderFooterViewReuseIdentifier: Header.identifier)
        dishlist.delegate = self
        dishlist.dataSource = self
        dishlist.translatesAutoresizingMaskIntoConstraints = false
        return dishlist
    }()

    //: MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        configuration()
        setupView()
        setupNetwork()
    }

    //: MARK: - Setups

    private func setupNetwork() {
        dishlistViewModel?.fetchCategoryDishes(categoryId: category?.id ?? "") { [weak self] result in
            switch result {
            case .success(let dishes):
                ProgressHUD.dismiss()
                self?.dishes = dishes
                self?.dishlist.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }

    private func configuration() {
        dishlistViewModel = DishlistViewModel()
    }

    private func setupView() {
        title = category?.name ?? ""
    }
    
    private func setupHierarchy() {
        view.addSubview(dishlist)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            dishlist.topAnchor.constraint(equalTo: view.topAnchor),
            dishlist.rightAnchor.constraint(equalTo: view.rightAnchor),
            dishlist.leftAnchor.constraint(equalTo: view.leftAnchor),
            dishlist.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//: MARK: - Extension DataSource

extension DishlistView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishOrderCell.identifier,
                                                       for: indexPath) as? DishOrderCell else { return UITableViewCell() }
        cell.dishListSetup(dish: dishes[indexPath.row])
        return cell
    }
}

//: MARK: - Extension Delegate

extension DishlistView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dishlistViewModel?.transitionDetail(complitionHandler: goToDetail, array: dishes[indexPath.row])
        dishlist.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Header.identifier) as? Header else {
            return UITableViewHeaderFooterView() }
        header.header.text = DishlistConstants.header
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       50
    }
}




