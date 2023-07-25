//
//  OrderlistView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 28.06.2023.
//

import ProgressHUD
import UIKit

fileprivate enum OrderlistConstants {

    //: MARK: - StringConstants

    static let header = "ЗАКАЗЫ"
}


class OrderlistView: UIViewController, OrderController {
    var goToOrder: ((Order?) -> ())?
    var orderlistViewModel: OrderlistViewModelProtocol?
    var orders: [Order] = []

    //: MARK: - UI Elements

    private lazy var orderList: UITableView = {
        let orderList = UITableView(frame: .zero, style: .plain)
        orderList.register(DishOrderCell.self, forCellReuseIdentifier: DishOrderCell.identifier)
        orderList.register(Header.self, forHeaderFooterViewReuseIdentifier: Header.identifier)
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
        setupView()
        setupNetwork()
    }

    //: MARK: - Setups

    private func setupNetwork() {
        ProgressHUD.show()
        orderlistViewModel?.fetchOrders { [weak self] result in
            switch result {
            case .success(let orders):
                ProgressHUD.dismiss()
                self?.orders = orders
                self?.orderList.reloadData()
                print(orders)
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }

    private func configuration() {
        orderlistViewModel = OrderlistViewModel()
    }

    private func setupView() {
        title = "Мои заказы"
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
        orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishOrderCell.identifier,
                                                       for: indexPath) as? DishOrderCell else { return UITableViewCell() }
        cell.orderListSetup(order: orders[indexPath.row])
        return cell
    }
}

//: MARK: - Extension Delegate

extension OrderlistView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderlistViewModel?.transitionDetail(complitionHandler: goToOrder, array: orders[indexPath.row])
        orderList.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Header.identifier) as? Header else {
            return UITableViewHeaderFooterView() }
        header.header.text = "ЗАКАЗЫ"
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       50
    }
}
