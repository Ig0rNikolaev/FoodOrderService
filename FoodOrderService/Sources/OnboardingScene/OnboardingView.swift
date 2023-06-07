//
//  OnboardingView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 02.06.2023.
//

import UIKit

final class OnboardingView: UIViewController {

    private var onboardingViewModel: OnboardingViewModel?

    //: MARK: - UI Elements

    private lazy var collectionOnboarding: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private lazy var pageOnboarding: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.pageIndicatorTintColor = .systemGray3
        page.currentPageIndicatorTintColor = .black
        page.backgroundStyle = .automatic
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()

    private lazy var buttonOnboarding: UIButton = {
        let button = UIButton()
        button.setTitle("Дальше", for: .normal)
        button.backgroundColor = .systemBlue
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
    }

    //: MARK: - Setups

    private func configuration() {
        onboardingViewModel = OnboardingViewModel()
    }

    @objc func tabButton() {

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
            collectionOnboarding.topAnchor.constraint(equalTo: view.topAnchor),
            collectionOnboarding.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionOnboarding.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionOnboarding.bottomAnchor.constraint(equalTo: pageOnboarding.topAnchor, constant: -20),

            stackButtonPages.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackButtonPages.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),

            buttonOnboarding.widthAnchor.constraint(equalToConstant: 175),
            buttonOnboarding.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

extension OnboardingView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingViewModel?.slides.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier,
                                                           for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        cell.setupCell(viewModel: onboardingViewModel, index: indexPath.item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: view.frame.height / 1.5)
    }
}
