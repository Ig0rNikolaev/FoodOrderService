//
//  DishlistCell.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 26.06.2023.
//

import UIKit

class DishlistCell: UITableViewCell {

    static let identifier = "DishlistCell"

    //: MARK: - UI Elements

    private lazy var dishImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var dishTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dishLowLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackLabel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dishTopLabel, dishLowLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    //: MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("Error")
    }

    //: MARK: - Setups

    private func setupHierarchy() {
        contentView.addSubview(dishImage)
        contentView.addSubview(stackLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            dishImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dishImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            stackLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackLabel.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
