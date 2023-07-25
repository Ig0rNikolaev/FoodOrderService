//
//  MainView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 13.06.2023.
//

import UIKit

fileprivate enum MainConstants {

    //: MARK: - StringConstants

    static let categoryHeader = "Категории"
    static let popularHeader = "Популярные блюда"
    static let cheffHeader =  "Блюда от шефа"
    static let defaultHeader = "default"
    static let titleButton = "title"
    static let imageButton = "cart"
}

 class MainView: UIViewController, SceneController {
    var mainViewModel: MainViewModelProtocol?
    var goToCollection: ((SectionName) -> ())?
    var goToDishCategory: ((DishCategory) -> ())?
    var goToDetail: ((Dish?) -> ())?
    var goToOrder: ((Order?) -> ())?

    var categories: [DishCategory] = []
    var populars: [Dish] = []
    var specials: [Dish] = []

    //: MARK: - UI Elements

    private lazy var collectionMain: UICollectionView = {
        let layout = createLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .systemGray6
        collection.register(MainTopCell.self, forCellWithReuseIdentifier: MainTopCell.identifier)
        collection.register(MainCategoryCell.self, forCellWithReuseIdentifier: MainCategoryCell.identifier)
        collection.register(MainCheffCell.self, forCellWithReuseIdentifier: MainCheffCell.identifier)
        collection.register(MainPopularCell.self, forCellWithReuseIdentifier: MainPopularCell.identifier)
        collection.register(MainCategoryHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: MainCategoryHeader.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .lightGray
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        navigationBar()
        configuration()
        setupNetwork()
    }

    //: MARK: - Actions

    @objc func addFood() {
        mainViewModel?.transitionOrder(complitionHandler: goToOrder)
    }

    //: MARK: - Setups

     func setupNetwork() {
         indicator.startAnimating()
         DispatchQueue.main.async {
             self.mainViewModel?.fetchAllDishes { [weak self] result in
                 switch result {
                 case .success(let success):
                     self?.indicator.stopAnimating()
                     self?.categories = success.categories ?? []
                     self?.populars = success.populars ?? []
                     self?.specials = success.specials ?? []
                     self?.collectionMain.reloadData()
                 case .failure(let failure):
                     print(failure)
                 }
             }
         }
     }

    private func configuration() {
        mainViewModel = MainViewModel()
    }

    private func setupView() {
        title = "Меню"
    }

    private func setupHierarchy() {
        view.addSubview(collectionMain)
        view.addSubview(indicator)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionMain.topAnchor.constraint(equalTo: view.topAnchor),
            collectionMain.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionMain.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionMain.leftAnchor.constraint(equalTo: view.leftAnchor),

            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func navigationBar() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: MainConstants.titleButton,
                                                            image: UIImage(systemName: MainConstants.imageButton),
                                                            target: self, action: #selector(addFood))
    }

    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .estimated(60))
        let headerSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return headerSection
    }

    func createSectionsTop() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)

        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let smallItemLayout = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItemLayout.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let smallGropSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let smallGroupLayout = NSCollectionLayoutGroup.vertical(layoutSize: smallGropSize, subitem: smallItemLayout, count: 2)

        let gropSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(3/5))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: gropSize, subitems: [itemLayout, smallGroupLayout])
        groupLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 10, trailing: 6)

        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        return sectionLayout
    }

    func createSections(gorupSizeWidth: CGFloat, gorupSizeHeight: CGFloat, groupCount: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let gorupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(gorupSizeWidth), heightDimension: .fractionalHeight(gorupSizeHeight))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: gorupSize, subitem: itemLayout, count: groupCount)
        groupLayout.interItemSpacing = NSCollectionLayoutSpacing.fixed(15)
        groupLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 20, trailing: 6)

        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.boundarySupplementaryItems = [createSectionHeader()]
        sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        sectionLayout.orthogonalScrollingBehavior = .groupPaging
        return sectionLayout
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [self] (section, _) -> NSCollectionLayoutSection in
            switch SectionName(rawValue: section) {
            case .top:
                return createSectionsTop()
            case .category:
                return createSections(gorupSizeWidth: 0.39, gorupSizeHeight: 0.15, groupCount: 2)
            case .popular:
                return createSections(gorupSizeWidth: 0.47, gorupSizeHeight: 0.35, groupCount: 1)
            case .cheff:
                return createSections(gorupSizeWidth: 0.8, gorupSizeHeight: 0.12, groupCount: 1)
            default:
                return createSections(gorupSizeWidth: 0, gorupSizeHeight: 0, groupCount: 0)
            }
        }
    }
}

//: MARK: - Extension DataSource

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionName(rawValue: section) {
        case .top:
            return mainViewModel?.topCategory.count ?? 0
        case .category:
            return categories.count
        case .popular:
            return populars.count
        case .cheff:
            return specials.count
        default:
            return specials.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionName(rawValue: indexPath.section) {
        case .top:
            guard let cellCategory = collectionView.dequeueReusableCell(withReuseIdentifier: MainTopCell.identifier,
                                                                        for: indexPath) as? MainTopCell else { return UICollectionViewCell() }
            mainViewModel?.configureTopCell(cell: cellCategory, index: indexPath.item)
            cellCategory.layer.cornerRadius = 10
            return cellCategory
        case .category:
            guard let cellCategory = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoryCell.identifier,
                                                                        for: indexPath) as? MainCategoryCell else { return UICollectionViewCell() }
            cellCategory.setup(category: categories[indexPath.row])
            cellCategory.shadow(cell: cellCategory)
            return cellCategory
        case .popular:
            guard let cellPopular = collectionView.dequeueReusableCell(withReuseIdentifier: MainPopularCell.identifier,
                                                                       for: indexPath)  as? MainPopularCell else { return UICollectionViewCell() }
            cellPopular.setup(category: populars[indexPath.row])
            cellPopular.shadow(cell: cellPopular)
            return cellPopular
        case .cheff:
            guard let cellCheff = collectionView.dequeueReusableCell(withReuseIdentifier: MainCheffCell.identifier,
                                                                     for: indexPath) as? MainCheffCell else { return UICollectionViewCell() }
            cellCheff.setup(category: specials[indexPath.row])
            cellCheff.shadow(cell: cellCheff)
            return cellCheff
        default:
            guard let cellCategory = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoryCell.identifier,
                                                                        for: indexPath) as? MainCategoryCell else { return UICollectionViewCell() }
            cellCategory.shadow(cell: cellCategory)
            return cellCategory
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: MainCategoryHeader.identifier,
                                                                           for: indexPath) as? MainCategoryHeader else { return UICollectionReusableView() }
        switch SectionName(rawValue: indexPath.section) {
        case .top:
            return header
        case .category:
            header.categoryHeader.text = MainConstants.categoryHeader
            return header
        case .popular:
            header.categoryHeader.text = MainConstants.popularHeader
            return header
        case .cheff:
            header.categoryHeader.text = MainConstants.cheffHeader
            return header
        default:
            header.categoryHeader.text = MainConstants.defaultHeader
            return header
        }
    }
}

//: MARK: - Extension Delegate

extension MainView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch SectionName(rawValue: indexPath.section) {
        case .category:
            mainViewModel?.transitionSection(complitionHandler: goToCollection, index: SectionName(rawValue: indexPath.section))
            mainViewModel?.transitionCategory(complitionHandler: goToDishCategory, array: categories[indexPath.row])
        case .popular:
            mainViewModel?.transitionSection(complitionHandler: goToCollection, index: SectionName(rawValue: indexPath.section))
            mainViewModel?.transitionDetail(complitionHandler: goToDetail, array: populars[indexPath.row])
        case .cheff:
            mainViewModel?.transitionSection(complitionHandler: goToCollection, index: SectionName(rawValue: indexPath.section))
            mainViewModel?.transitionDetail(complitionHandler: goToDetail, array: specials[indexPath.row])
        default:
            break
        }
    }
}
