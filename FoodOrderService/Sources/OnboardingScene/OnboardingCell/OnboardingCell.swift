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
    
    lazy var imageСonteinerOnboardingCell: UIView = {
        let image = UIView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var imageOnboardingCell: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var labelTitleOnboardingCell: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelDescriptionOnboardingCell: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackLabelOnboardingCell: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelTitleOnboardingCell, labelDescriptionOnboardingCell])
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
        imageСonteinerOnboardingCell.addSubview(imageOnboardingCell)
        contentView.addSubview(imageСonteinerOnboardingCell)
        contentView.addSubview(stackLabelOnboardingCell)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageOnboardingCell.topAnchor.constraint(equalTo: imageСonteinerOnboardingCell.topAnchor),
            imageOnboardingCell.rightAnchor.constraint(equalTo: imageСonteinerOnboardingCell.rightAnchor),
            imageOnboardingCell.bottomAnchor.constraint(equalTo: imageСonteinerOnboardingCell.bottomAnchor),
            imageOnboardingCell.leftAnchor.constraint(equalTo: imageСonteinerOnboardingCell.leftAnchor),

            imageСonteinerOnboardingCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageСonteinerOnboardingCell.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageСonteinerOnboardingCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -170),
            imageСonteinerOnboardingCell.leftAnchor.constraint(equalTo: contentView.leftAnchor),

            stackLabelOnboardingCell.topAnchor.constraint(equalTo: imageСonteinerOnboardingCell.bottomAnchor),
            stackLabelOnboardingCell.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackLabelOnboardingCell.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }
    
    func setupCell(index: Int) {
        onboardingViewModel.setupCellView(imageCell: imageOnboardingCell,
                                          labelCellTitle: labelTitleOnboardingCell,
                                          labelCellDescription: labelDescriptionOnboardingCell,
                                          index: index)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageOnboardingCell.image = nil
        labelTitleOnboardingCell.text = nil
        labelDescriptionOnboardingCell.text = nil
    }
}
