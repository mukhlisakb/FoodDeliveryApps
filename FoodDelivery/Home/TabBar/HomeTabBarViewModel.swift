//
//  HomeTabBarViewModel.swift
//  FoodDelivery
//
//  Created by Mukhlis Akbar on 17/07/24.
//

import Foundation

protocol HomeTabBarViewModelProtocol: AnyObject {
    func onViewWillAppear()
    var delegate: HomeTabBarViewModelDelegate? {get set}
}

protocol HomeTabBarViewModelDelegate: AnyObject {
    func setUpView()
}

class HomeTabBarViewModel: HomeTabBarViewModelProtocol {
    weak var delegate: HomeTabBarViewModelDelegate?
    
    func onViewWillAppear() {
        delegate?.setUpView()
    }
    
    
}
