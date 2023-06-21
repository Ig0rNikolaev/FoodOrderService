//
//  DetailView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 21.06.2023.
//

import Foundation
import UIKit

class DetailView: UIViewController {

    //: MARK: - UI Elements

    private lazy var imageDetail: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .blue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var labelTitleDetail: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var labelCaloriesDetail: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var labelDescriptionDetail: UILabel = {
        let label = UILabel()
        label.text = "риыорирви роивоив воиовиоив оиоивовв ававав вавава ававвав ваавав"
        label.textColor = .systemGray
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textDetail: UITextField = {
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

    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        configuration()
    }

    //: MARK: - Setups

    private func configuration() {

    }

    private func setupView() {
        title = "Detail View"
        view.backgroundColor = .systemGray6
    }

    private func setupHierarchy() {
        view.addSubview(imageDetail)
        view.addSubview(labelTitleDetail)
        view.addSubview(labelDescriptionDetail)
        view.addSubview(labelCaloriesDetail)
        view.addSubview(textDetail)
        view.addSubview(buttonDetail)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageDetail.topAnchor.constraint(equalTo: view.topAnchor),
            imageDetail.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            imageDetail.leftAnchor.constraint(equalTo: view.leftAnchor),

            labelTitleDetail.topAnchor.constraint(equalTo: imageDetail.bottomAnchor, constant: 20),
            labelTitleDetail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            labelDescriptionDetail.topAnchor.constraint(equalTo: labelTitleDetail.bottomAnchor, constant: 10),
            labelDescriptionDetail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            labelDescriptionDetail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

            textDetail.topAnchor.constraint(equalTo: labelDescriptionDetail.bottomAnchor, constant: 10),
            textDetail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textDetail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            textDetail.heightAnchor.constraint(equalToConstant: 50),

            buttonDetail.topAnchor.constraint(equalTo: textDetail.bottomAnchor, constant: 20),
            buttonDetail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonDetail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            buttonDetail.heightAnchor.constraint(equalToConstant: 50),

            labelCaloriesDetail.topAnchor.constraint(equalTo: imageDetail.bottomAnchor, constant: 20),
            labelCaloriesDetail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
