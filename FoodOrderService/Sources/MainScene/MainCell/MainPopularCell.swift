//
//  MainPopularCell.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 19.06.2023.
//

import UIKit

class MainPopularCell: UICollectionViewCell {

    static let identifier = "MainPopularCell"

    //: MARK: - UI Elements

    private lazy var containerImagePopular: UIView = {
        let container = UIView()
        container.backgroundColor = .systemGreen
        container.layer.cornerRadius = 5
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var imagePopular: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var upLabelPopular: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lowLabelPopular: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var secondLowLabelPopular: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lowStackLabel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lowLabelPopular, secondLowLabelPopular])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalSpacing
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
        containerImagePopular.addSubview(imagePopular)
        contentView.addSubview(containerImagePopular)
        contentView.addSubview(upLabelPopular)
        contentView.addSubview(lowStackLabel)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imagePopular.topAnchor.constraint(equalTo: containerImagePopular.topAnchor),
            imagePopular.rightAnchor.constraint(equalTo: containerImagePopular.rightAnchor),
            imagePopular.bottomAnchor.constraint(equalTo: containerImagePopular.bottomAnchor),
            imagePopular.leftAnchor.constraint(equalTo: containerImagePopular.leftAnchor),

            upLabelPopular.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            upLabelPopular.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),

            containerImagePopular.topAnchor.constraint(equalTo: upLabelPopular.bottomAnchor, constant: 5),
            containerImagePopular.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            containerImagePopular.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            containerImagePopular.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),

            lowStackLabel.topAnchor.constraint(equalTo: containerImagePopular.bottomAnchor, constant: 10),
            lowStackLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

