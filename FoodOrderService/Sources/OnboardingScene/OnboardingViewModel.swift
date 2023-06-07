//
//  OnboardingViewModel.swift
//  FoodOrderService
//
//  Created by Игорь Николаев on 07.06.2023.
//

import UIKit

class OnboardingViewModel {
    var slides = [OnboardingModel(title: "Быстрая доставка до Вашей двери",
                                  description: "Система онлайн заказа продуктов и блюд из магазинов и ресторанов",
                                  view: UIImage(named: "slide1") ?? UIImage()),
                  OnboardingModel(title: "2", description: "2", view:  UIImage(named: "slide2") ?? UIImage()),
                  OnboardingModel(title: "3", description: "3", view:  UIImage(named: "slide3") ?? UIImage())
    ]
}
