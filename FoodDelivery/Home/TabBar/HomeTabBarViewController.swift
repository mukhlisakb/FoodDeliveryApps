//
//  HomeTabBarViewController.swift
//  FoodDelivery
//
//  Created by Mukhlis Akbar on 17/07/24.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    let viewModel: HomeTabBarViewModelProtocol
    
    init(viewModel: HomeTabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewWillAppear()
    }
}


//Membuat Tabbar dari VM Delegate
extension HomeTabBarViewController: HomeTabBarViewModelDelegate {
    func setUpView() {
        let homeTabBar: UITabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        let searchTabBar: UITabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let cartTabBar: UITabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart.fill"), tag: 2)
        
        let homeVM: HomeViewModel = HomeViewModel()
        let homeVC: HomeViewController = HomeViewController(viewModel: homeVM)
        homeVC.tabBarItem = homeTabBar
        
        let searchVC: SearchViewController = SearchViewController(nibName: nil, bundle: nil)
        searchVC.tabBarItem = searchTabBar
        
        let cartVC: CartViewController = CartViewController(nibName: nil, bundle: nil)
        cartVC.tabBarItem = cartTabBar
        
        viewControllers = [homeVC, searchVC, cartVC]
        
        tabBar.tintColor = UIColor.systemOrange
        tabBar.backgroundColor = .white
        navigationItem.title = homeVC.tabBarItem.title
        
        delegate = self
    }
}

// Membuat animasi View setiap TabBar
extension HomeTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve])
            navigationItem.title = viewController.tabBarItem.title
        }
        return true
    }
}
