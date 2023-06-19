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
        container.backgroundColor = .systemBlue
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var imageCategory: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var labelCategory: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
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

            containerImageCategory.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerImageCategory.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100),
            containerImageCategory.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerImageCategory.leftAnchor.constraint(equalTo: contentView.leftAnchor),

            labelCategory.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelCategory.leftAnchor.constraint(equalTo: containerImageCategory.rightAnchor, constant: 10)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
