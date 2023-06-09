//
//  OnboardingViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 07.06.2023.
//

import UIKit

protocol OnboardingViewModelProtocol: AnyObject {
    var slides: [OnboardingModel] { get set }
    func configureCell(cell: OnboardingCell, at index: Int)
    func button(currentPage: inout Int, collectionView: UICollectionView)
    func setupCellView(imageCell: UIImageView, labelCellTitle: UILabel, labelCellDescription: UILabel, index: Int)
}

class OnboardingViewModel: OnboardingViewModelProtocol {
    var slides = [OnboardingModel(title: "Оформление заказов\n онлайн 24/7",
                                  description: "Система онлайн заказа продуктов и блюд из магазинов и ресторанов не выходя из дома",
                                  view: UIImage(named: "slide4") ?? UIImage()),
                  OnboardingModel(title: "Быстрая доставка до Вашей двери",
                                  description: "Курьер в короткие сроки заберет Ваша заказ и доставит его Вам",
                                  view:  UIImage(named: "slide3") ?? UIImage()),
                  OnboardingModel(title: "Любые блюда у Вас на столе",
                                  description: "Любые деликатесы и блюда разной кухни, стрит-фуд из ресторанов, кафе и баров",
                                  view:  UIImage(named: "slide2") ?? UIImage())
    ]

    func setupCellView(imageCell: UIImageView, labelCellTitle: UILabel, labelCellDescription: UILabel, index: Int) {
        imageCell.image = slides[index].view
        labelCellTitle.text = slides[index].title
        labelCellDescription.text = slides[index].description
    }

    func configureCell(cell: OnboardingCell, at index: Int) {
        cell.setupCell(index: index)
    }

    func button(currentPage: inout Int, collectionView: UICollectionView) {
        currentPage += 1
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

