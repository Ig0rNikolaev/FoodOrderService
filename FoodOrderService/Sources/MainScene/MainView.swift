//
//  MainView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 13.06.2023.
//

import UIKit

class MainView: UIViewController {


    //: MARK: - UI Elements

    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    //: MARK: - Setups

    private func setupView() {
        view.backgroundColor = .white
        title = "MAINVIEW"
    }

    private func setupHierarchy() {

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

        ])
    }
}
