//
//  OnboardingView.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 02.06.2023.
//

import UIKit

final class OnboardingView: UIViewController {

    //: MARK: - UI Elements

    private lazy var collectionOnboarding: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.register(Onboarding.self, forCellWithReuseIdentifier: Onboarding.identifier)
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
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tabButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    //: MARK: - Setups

    @objc func tabButton() {

    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(collectionOnboarding)
        view.addSubview(pageOnboarding)
        view.addSubview(buttonOnboarding)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
//            collectionOnboarding.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            collectionOnboarding.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            collectionOnboarding.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//            collectionOnboarding.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            collectionOnboarding.bottomAnchor.constraint(equalTo: pageOnboarding.topAnchor, constant: -20),

            pageOnboarding.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageOnboarding.bottomAnchor.constraint(equalTo: buttonOnboarding.topAnchor, constant: -20),

            buttonOnboarding.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOnboarding.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            buttonOnboarding.widthAnchor.constraint(equalToConstant: 175),
            buttonOnboarding.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

extension OnboardingView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
