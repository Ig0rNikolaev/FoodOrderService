//
//  OrderlistView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 28.06.2023.
//

import Foundation

import UIKit

class OrderlistView: UIViewController, FlowController {
    var goToNextScreen: SceneNavigation?
    var orderlistViewModel: OrderlistViewModelProtocol?

    //: MARK: - UI Elements

    private lazy var orderList: UITableView = {
        let orderList = UITableView(frame: .zero, style: .insetGrouped)
        orderList.register(DishlistCell.self, forCellReuseIdentifier: DishlistCell.identifier)
        orderList.delegate = self
        orderList.dataSource = self
        orderList.translatesAutoresizingMaskIntoConstraints = false
        return orderList
    }()

    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        configuration()
    }

    //: MARK: - Setups

    private func configuration() {
        orderlistViewModel = OrderlistViewModel()
    }

    private func setupHierarchy() {
        view.addSubview(orderList)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            orderList.topAnchor.constraint(equalTo: view.topAnchor),
            orderList.rightAnchor.constraint(equalTo: view.rightAnchor),
            orderList.leftAnchor.constraint(equalTo: view.leftAnchor),
            orderList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//: MARK: - Extension DataSource

extension OrderlistView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishlistCell.identifier,
                                                       for: indexPath) as? DishlistCell else { return UITableViewCell() }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        10
    }
}

//: MARK: - Extension Delegate

extension OrderlistView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderlistViewModel?.transitionDetail(complitionHandler: goToNextScreen)
    }
}
