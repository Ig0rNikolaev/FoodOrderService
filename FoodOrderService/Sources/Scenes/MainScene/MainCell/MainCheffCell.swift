//
//  MainCheffCell.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 19.06.2023.
//

import Foundation

import UIKit

class MainCheffCell: UICollectionViewCell {

    static let identifier = "MainCheffCell"

    //: MARK: - UI Elements

    private lazy var containerImageCheff: UIView = {
        let container = UIView()
        container.backgroundColor = .systemYellow
        container.layer.cornerRadius = 5
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var imageCheff: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var topLabelCheff: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var middleLabelCheff: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lowLabelCheff: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackLabelCheff: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLabelCheff, middleLabelCheff, lowLabelCheff])
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    //: MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("fatalError")
    }

    //: MARK: - Setups

    func setupHierarchy() {
        contentView.addSubview(stackLabelCheff)
        contentView.addSubview(containerImageCheff)
        containerImageCheff.addSubview(imageCheff)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imageCheff.topAnchor.constraint(equalTo: containerImageCheff.topAnchor),
            imageCheff.rightAnchor.constraint(equalTo: containerImageCheff.rightAnchor),
            imageCheff.bottomAnchor.constraint(equalTo: containerImageCheff.bottomAnchor),
            imageCheff.leftAnchor.constraint(equalTo: containerImageCheff.leftAnchor),

            containerImageCheff.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
            containerImageCheff.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -225),
            containerImageCheff.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerImageCheff.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),

            stackLabelCheff.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackLabelCheff.leftAnchor.constraint(equalTo: containerImageCheff.rightAnchor, constant: 10),
            stackLabelCheff.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
        ])
    }

    func setup(category: Dish) {
        topLabelCheff.text = category.name
        middleLabelCheff.text = category.description
        lowLabelCheff.text = category.formattedCalories
        CreatureImageURL.shared.getDataImage(urlRequest: category.image, imageFood: imageCheff)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        topLabelCheff.text = nil
        middleLabelCheff.text = nil
        lowLabelCheff.text = nil
        imageCheff.image = nil
    }
}
