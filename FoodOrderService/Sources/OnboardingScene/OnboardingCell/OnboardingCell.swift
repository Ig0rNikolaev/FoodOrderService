//
//  OnboardingCell.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 07.06.2023.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"

    var onboardingViewModel: OnboardingViewModelProtocol = OnboardingViewModel()
    
    //: MARK: - UI Elements
    
    lazy var imageCellСonteiner: UIView = {
        let image = UIView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var imageCell: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var labelCellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelCellDescription: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackLabel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelCellTitle, labelCellDescription])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 15
        stack.distribution = .equalCentering
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
        imageCellСonteiner.addSubview(imageCell)
        contentView.addSubview(imageCellСonteiner)
        contentView.addSubview(stackLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: imageCellСonteiner.topAnchor),
            imageCell.rightAnchor.constraint(equalTo: imageCellСonteiner.rightAnchor),
            imageCell.bottomAnchor.constraint(equalTo: imageCellСonteiner.bottomAnchor),
            imageCell.leftAnchor.constraint(equalTo: imageCellСonteiner.leftAnchor),

            imageCellСonteiner.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCellСonteiner.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageCellСonteiner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -170),
            imageCellСonteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor),

            stackLabel.topAnchor.constraint(equalTo: imageCellСonteiner.bottomAnchor),
            stackLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }
    
    func setupCell(index: Int) {
        onboardingViewModel.setupCellView(imageCell: imageCell,
                                          labelCellTitle: labelCellTitle,
                                          labelCellDescription: labelCellDescription,
                                          index: index)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageCell.image = nil
        labelCellTitle.text = nil
        labelCellDescription.text = nil
    }
}
