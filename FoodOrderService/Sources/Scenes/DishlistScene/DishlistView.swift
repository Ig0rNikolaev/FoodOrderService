//
//  DishlistView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 26.06.2023.
//

import UIKit

class DishlistView: UIViewController, FlowController {
    var goToNextScreen: SceneNavigation?
    var dishlistViewModel: DishlistViewModelProtocol?

    //: MARK: - UI Elements

    private lazy var dishlist: UITableView = {
        let dishlist = UITableView(frame: .zero, style: .insetGrouped)
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
        configuration()
        setupView()
    }
    
    //: MARK: - Setups

    private func configuration() {
        dishlistViewModel = DishlistViewModel()
    }

    private func setupView() {
        title = "Список блюд"
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

extension DishlistView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dishlistViewModel?.transitionDetail(complitionHandler: goToNextScreen)
        dishlist.deselectRow(at: indexPath, animated: true)
    }
}
