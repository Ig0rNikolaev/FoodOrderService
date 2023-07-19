//
//  OnboardingView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 02.06.2023.
//

import UIKit

final class OnboardingView: UIViewController, FlowController {
    var goToNextScreen: SceneNavigation?
    var onboardingViewModel: OnboardingViewModelProtocol?
    var currentPage = 0 {
        didSet {
            pageOnboarding.currentPage = currentPage
            if currentPage == (onboardingViewModel?.slides.count ?? 0) - 1 {
                buttonOnboarding.setTitle("Начало", for: .normal)
            } else {
                buttonOnboarding.setTitle("Далее", for: .normal)
            }
        }
    }
    //: MARK: - UI Elements
    
    private lazy var collectionOnboarding: UICollectionView = {
        let layout = createLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        collection.contentInsetAdjustmentBehavior = .scrollableAxes
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var pageOnboarding: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = .systemGray3
        page.currentPageIndicatorTintColor = .black
        page.backgroundStyle = .automatic
        page.isUserInteractionEnabled = false
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    private lazy var buttonOnboarding: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Далее", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tabButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackButtonPages: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pageOnboarding, buttonOnboarding])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 25
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
        configuration()
        numberOfPages()
    }


    
    //: MARK: - Setups
    
   private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let gorupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: gorupSize, subitem: itemLayout, count: 1)
            groupLayout.interItemSpacing = NSCollectionLayoutSpacing.fixed(5)
            
            let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
            sectionLayout.orthogonalScrollingBehavior = .groupPaging
            return sectionLayout
        }
    }

    private func numberOfPages() {
        let pagesCount = onboardingViewModel?.slides.count ?? 0
        pageOnboarding.numberOfPages = pagesCount
    }
    
    private func configuration() {
        onboardingViewModel = OnboardingViewModel()
    }
    
    @objc func tabButton() {
        onboardingViewModel?.button(currentPage: &currentPage,
                                    collectionView: collectionOnboarding,
                                    complitionHandler: goToNextScreen)
        buttonOnboarding.clickButton(button: buttonOnboarding)
    }

    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubview(collectionOnboarding)
        view.addSubview(stackButtonPages)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionOnboarding.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionOnboarding.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionOnboarding.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionOnboarding.bottomAnchor.constraint(equalTo: stackButtonPages.topAnchor),
            
            stackButtonPages.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackButtonPages.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            buttonOnboarding.widthAnchor.constraint(equalToConstant: 175),
            buttonOnboarding.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

//: MARK: - Extension DataSource

extension OnboardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingViewModel?.slides.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier,
                                                            for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        cell.onboardingViewModel.configureCell(cell: cell, at: indexPath.row)
        return cell
    }
}

//: MARK: - Extension Delegate

extension OnboardingView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        currentPage = visibleIndexPaths.first?.item ?? 0
    }
}
