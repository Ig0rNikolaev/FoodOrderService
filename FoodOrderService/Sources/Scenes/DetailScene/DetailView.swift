//
//  DetailView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 21.06.2023.
//

import Foundation
import UIKit

class DetailView: UIViewController, DetailController {
    var goToDetail: ((Dish?) -> ())?

    var dish: Dish? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.labelTitleDetail.text = self?.dish?.name ?? ""
                self?.labelDescriptionDetail.text = self?.dish?.description ?? ""
                self?.labelCaloriesDetail.text = self?.dish?.formattedCalories ?? ""
                CreatureImageURL.shared.getDataImage(urlRequest: self?.dish?.image, imageFood: self?.imageDetail ?? UIImageView())
            }
        }
    }

    //: MARK: - UI Elements

    lazy var imageDetail: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .blue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var labelTitleDetail: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelCaloriesDetail: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelDescriptionDetail: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        label.textColor = .systemGray
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var textDetail: UITextField = {
        let text = UITextField()
        text.textAlignment = .left
        text.backgroundColor = .white
        text.textAlignment = .center
        text.layer.cornerRadius = 5
        text.borderStyle = .roundedRect
        text.attributedPlaceholder = NSAttributedString(string: text.placeholder ?? "Введите Ваше имя",
                                                        attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private lazy var buttonDetail: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.shadowButton()
        button.layer.cornerRadius = 5
        button.setTitle("Добавить в заказ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelTitleDetail, labelCaloriesDetail])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    //: MARK: - Setups

    private func setupView() {
        view.backgroundColor = .systemGray6
    }

    private func setupHierarchy() {
        view.addSubview(imageDetail)
        view.addSubview(labelStack)
        view.addSubview(labelDescriptionDetail)
        view.addSubview(textDetail)
        view.addSubview(buttonDetail)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageDetail.topAnchor.constraint(equalTo: view.topAnchor),
            imageDetail.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageDetail.leftAnchor.constraint(equalTo: view.leftAnchor),

            labelStack.topAnchor.constraint(equalTo: imageDetail.bottomAnchor, constant: 20),
            labelStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            labelStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

            labelDescriptionDetail.topAnchor.constraint(equalTo: labelTitleDetail.bottomAnchor, constant: 10),
            labelDescriptionDetail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            labelDescriptionDetail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

            textDetail.topAnchor.constraint(equalTo: labelDescriptionDetail.bottomAnchor, constant: 20),
            textDetail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textDetail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            textDetail.heightAnchor.constraint(equalToConstant: 50),

            buttonDetail.topAnchor.constraint(equalTo: textDetail.bottomAnchor, constant: 20),
            buttonDetail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonDetail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            buttonDetail.heightAnchor.constraint(equalToConstant: 50),
            buttonDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }

    func setupDish(dishs: Dish?) {
        labelTitleDetail.text = dishs?.name ?? ""
        labelDescriptionDetail.text = dishs?.description ?? ""
        labelCaloriesDetail.text = dishs?.formattedCalories ?? ""
        CreatureImageURL.shared.getDataImage(urlRequest: dishs?.image, imageFood: imageDetail)
    }
}
