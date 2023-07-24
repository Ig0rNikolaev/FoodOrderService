//
//  DishlistCell.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 26.06.2023.
//

import UIKit

class DishOrderCell: UITableViewCell {

    static let identifier = "DishOrderCell"

    //: MARK: - UI Elements

    private lazy var dishImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var dishTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dishLowLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
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
            dishImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            dishImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dishImage.widthAnchor.constraint(equalToConstant: 45),
            dishImage.heightAnchor.constraint(equalToConstant: 45),

            stackLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackLabel.leftAnchor.constraint(equalTo: dishImage.rightAnchor, constant: 20),
            stackLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }

    func dishListSetup(dish: Dish) {
        CreatureImageURL.shared.getDataImage(urlRequest: dish.image, imageFood: dishImage)
        dishTopLabel.text = dish.name
        dishLowLabel.text = dish.description
    }

    func orderListSetup(order: Order) {
        CreatureImageURL.shared.getDataImage(urlRequest: order.dish?.image, imageFood: dishImage)
        dishTopLabel.text = order.dish?.name
        dishLowLabel.text = order.dish?.description
    }
}
