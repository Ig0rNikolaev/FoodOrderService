//
//  MainCategoryCell.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 15.06.2023.
//

import UIKit

class MainCategoryCell: UICollectionViewCell {

    static let identifier = "MainCategoryCell"

    //: MARK: - UI Elements

    private lazy var containerImageCategory: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 5
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

        lazy var imageCategory: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

        lazy var labelCategory: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(labelCategory)
        contentView.addSubview(containerImageCategory)
        containerImageCategory.addSubview(imageCategory)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imageCategory.topAnchor.constraint(equalTo: containerImageCategory.topAnchor),
            imageCategory.rightAnchor.constraint(equalTo: containerImageCategory.rightAnchor),
            imageCategory.bottomAnchor.constraint(equalTo: containerImageCategory.bottomAnchor),
            imageCategory.leftAnchor.constraint(equalTo: containerImageCategory.leftAnchor),

            containerImageCategory.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerImageCategory.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100),
            containerImageCategory.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            containerImageCategory.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),

            labelCategory.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelCategory.leftAnchor.constraint(equalTo: containerImageCategory.rightAnchor, constant: 10),
            labelCategory.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }

    func setup(category: DishCategory) {
        labelCategory.text = category.name
        CreatureImageURL.shared.getDataImage(urlRequest: category.image, imageFood: imageCategory)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
