//
//  MainTopCell.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 20.06.2023.
//

import UIKit

class MainTopCell: UICollectionViewCell {

    static let identifier = "MainTopCell"

    var mainViewModel: MainViewModelProtocol = MainViewModel()

    //: MARK: - UI Elements

    private lazy var containerImageCategory: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBlue
        container.layer.cornerRadius = 10
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    lazy var imageCategory: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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

            containerImageCategory.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerImageCategory.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerImageCategory.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            containerImageCategory.leftAnchor.constraint(equalTo: contentView.leftAnchor),

            labelCategory.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelCategory.topAnchor.constraint(equalTo: containerImageCategory.bottomAnchor, constant: 5)
        ])
    }
    
    func setupTopCell(index: Int) {
        mainViewModel.setupCellView(imageCell: imageCategory, labelCellDescription: labelCategory, index: index)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageCategory.image = nil
        labelCategory.text = nil
    }
}
