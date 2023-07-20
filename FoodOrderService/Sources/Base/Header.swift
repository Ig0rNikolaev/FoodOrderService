//
//  DishlistHeader.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 20.07.2023.
//

import UIKit

class Header: UITableViewHeaderFooterView {
    static let identifier = "Header"

    //: MARK: - UI Elements

        lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //: MARK: - Lifecycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("Error")
    }

    //: MARK: - Setups

    private func setupHierarchy() {
        contentView.addSubview(header)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            header.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
}
