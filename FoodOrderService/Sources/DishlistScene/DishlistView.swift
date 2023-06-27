//
//  DishlistView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 26.06.2023.
//

import UIKit

class DishlistView: UIViewController {
    
    //: MARK: - UI Elements

    private lazy var dishlist: UITableView = {
        let dishlist = UITableView(frame: .zero, style: .plain)
        dishlist.register(DishlistCell.self, forCellReuseIdentifier: DishlistCell.identifier)
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
    }
    
    //: MARK: - Setups
    
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
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishlistCell.identifier,
                                                       for: indexPath) as? DishlistCell else { return UITableViewCell() }
        return cell
    }
}

//: MARK: - Extension Delegate

extension DishlistView: UITableViewDelegate {

}
