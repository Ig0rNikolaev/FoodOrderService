//
//  OnboardingViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 07.06.2023.
//

import UIKit

fileprivate enum OnboardingConstantsVM {

    //: MARK: - StringConstants

    static let titleSlideOne = "Оформление заказов\n онлайн 24/7"
    static let descriptionSlideOne = "Система онлайн заказа продуктов и блюд из магазинов и ресторанов не выходя из дома"
    static let viewSlideOne = "slide1"
    static let titleSlideTwo = "Быстрая доставка до Вашей двери"
    static let descriptionSlideTwo = "Курьер в короткие сроки заберет Ваша заказ и доставит его Вам"
    static let viewSlideTwo = "slide2"
    static let titleSlideThree = "Любые блюда у Вас на столе"
    static let descriptionSlideThree = "Любые деликатесы и блюда разной кухни, стрит-фуд из ресторанов, кафе и баров"
    static let viewSlideThree = "slide3"
}

protocol OnboardingViewModelProtocol: AnyObject {
    var slides: [OnboardingModel] { get set }
    func configureCell(cell: OnboardingCell, at index: Int)
    func button(currentPage: inout Int, collectionView: UICollectionView, complitionHandler: SceneNavigation?)
    func setupCellView(imageCell: UIImageView, labelCellTitle: UILabel, labelCellDescription: UILabel, index: Int)
}

class OnboardingViewModel: OnboardingViewModelProtocol {
    var slides = [OnboardingModel(title: OnboardingConstantsVM.titleSlideOne,
                                  description: OnboardingConstantsVM.descriptionSlideOne,
                                  view: UIImage(named: OnboardingConstantsVM.viewSlideOne) ?? UIImage()),
                  OnboardingModel(title: OnboardingConstantsVM.titleSlideTwo,
                                  description: OnboardingConstantsVM.descriptionSlideTwo,
                                  view:  UIImage(named: OnboardingConstantsVM.viewSlideTwo) ?? UIImage()),
                  OnboardingModel(title: OnboardingConstantsVM.titleSlideOne,
                                  description: OnboardingConstantsVM.descriptionSlideThree,
                                  view:  UIImage(named: OnboardingConstantsVM.viewSlideThree) ?? UIImage())
    ]
    
    func setupCellView(imageCell: UIImageView, labelCellTitle: UILabel, labelCellDescription: UILabel, index: Int) {
        imageCell.image = slides[index].view
        labelCellTitle.text = slides[index].title
        labelCellDescription.text = slides[index].description
    }
    
    func configureCell(cell: OnboardingCell, at index: Int) {
        cell.setupCell(index: index)
    }
    
    func button(currentPage: inout Int, collectionView: UICollectionView, complitionHandler: SceneNavigation?) {
        if currentPage == slides.count - 1 {
            complitionHandler?()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
