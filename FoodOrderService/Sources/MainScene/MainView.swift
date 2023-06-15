//
//  MainView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 13.06.2023.
//

import UIKit
import Foundation

class MainView: UIViewController {

    //: MARK: - UI Elements

    private lazy var collectionMain: UICollectionView = {
        let layout = createLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MainCategoryCell.self, forCellWithReuseIdentifier: MainCategoryCell.identifier)
        collection.register(MainCategoryHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: MainCategoryHeader.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        navigationBar()
    }

    //: MARK: - Actions

    @objc func addFood() {

    }

    //: MARK: - Setups

    private func setupView() {
        title = "Main View"
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(collectionMain)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionMain.topAnchor.constraint(equalTo: view.topAnchor),
            collectionMain.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionMain.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionMain.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }

    private func navigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .systemGray2
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Item", image: UIImage(systemName: "cart.fill"), target: self, action: #selector(addFood))
    }

    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .estimated(60))
        let headerSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return headerSection
    }

    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let gorupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.2))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: gorupSize, subitem: itemLayout, count: 2)
        groupLayout.interItemSpacing = NSCollectionLayoutSpacing.fixed(15)

        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 20, trailing: 6)
        sectionLayout.boundarySupplementaryItems = [createSectionHeader()]
        sectionLayout.orthogonalScrollingBehavior = .groupPaging
        return sectionLayout
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [self] (section, _) -> NSCollectionLayoutSection in
            switch section {
            case 0:
                return createSection()
            case 1:
                return createSection()
            case 2:
                return createSection()
            default:
                return createSection()
            }
        }
    }
}

//: MARK: - Extension Delegate, DataSource

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoryCell.identifier,
                                                            for: indexPath) as? MainCategoryCell else { return UICollectionViewCell() }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: MainCategoryHeader.identifier,
                                                                           for: indexPath) as? MainCategoryHeader else { return UICollectionReusableView() }
        switch indexPath.section {
        case 0:
            header.categoryHeader.text = "Категории"
            return header
        case 1:
            header.categoryHeader.text = "Популярные блюда"
            return header
        case 2:
            header.categoryHeader.text = "Блюда от шефа"
            return header
        default:
            header.categoryHeader.text = "default"
            return header
        }
    }
}
