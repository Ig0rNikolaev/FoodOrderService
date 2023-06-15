//
//  MainCategoryHeader.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 15.06.2023.
//

import UIKit

class MainCategoryHeader: UICollectionReusableView {

    static let identifier = "MainCategoryHeader"

    //: MARK: - UI Elements

        lazy var categoryHeader: UILabel = {
        let header = UILabel()
        header.textColor = .black
        header.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()

    //: MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("fatalError")
    }

    //: MARK: - Setups

    func setupHierarchy() {
        addSubview(categoryHeader)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            categoryHeader.centerYAnchor.constraint(equalTo: centerYAnchor.self),
            categoryHeader.centerXAnchor.constraint(equalTo: centerXAnchor.self),
            categoryHeader.leftAnchor.constraint(equalTo: leftAnchor.self, constant: 20)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        categoryHeader.text = nil
    }
}
