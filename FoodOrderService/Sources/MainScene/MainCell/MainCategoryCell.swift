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

    private lazy var containerImageMaineCell: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBlue
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var imageMainCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var labelMainCell: UILabel = {
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
        contentView.addSubview(labelMainCell)
        contentView.addSubview(containerImageMaineCell)
        containerImageMaineCell.addSubview(imageMainCell)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imageMainCell.topAnchor.constraint(equalTo: containerImageMaineCell.topAnchor),
            imageMainCell.rightAnchor.constraint(equalTo: containerImageMaineCell.rightAnchor),
            imageMainCell.bottomAnchor.constraint(equalTo: containerImageMaineCell.bottomAnchor),
            imageMainCell.leftAnchor.constraint(equalTo: containerImageMaineCell.leftAnchor),

            containerImageMaineCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerImageMaineCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100),
            containerImageMaineCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerImageMaineCell.leftAnchor.constraint(equalTo: contentView.leftAnchor),

            labelMainCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelMainCell.leftAnchor.constraint(equalTo: containerImageMaineCell.rightAnchor, constant: 10)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
