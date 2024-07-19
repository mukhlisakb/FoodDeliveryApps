//
//  HomeViewModel.swift
//  FoodDelivery
//
//  Created by Mukhlis Akbar on 17/07/24.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func onViewDidLoad()
    var delegate: HomeViewModelDelegate? { get set }
    func getRestaurantList() -> [RestaurantListCellModel]
    func getCuisineList() -> [CuisineListCellModel]
}

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
}

class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    
    private var restaurantListCellModel: [RestaurantListCellModel] = []
    private var cuisineList: [CuisineListCellModel] = []
    
    func onViewDidLoad() {
        fetchRestaurantList()
    }
    
    func getRestaurantList() -> [RestaurantListCellModel] {
        return restaurantListCellModel
    }
    
    func getCuisineList() -> [CuisineListCellModel] {
        return cuisineList
    }
}

private extension HomeViewModel {
    func fetchRestaurantList() {
        RestaurantListFetcher.requestRestaurantList { [weak self] restaurantList, error in
            guard let self = self else { return }
            if let restaurantList = restaurantList, !restaurantList.isEmpty {
                self.convertRestaurantListToRestaurantListCell(restaurantList: restaurantList)
                self.convertCuisineList(from: restaurantList)
                self.delegate?.reloadData()
            } else if let error = error {
                // Handle the error appropriately, e.g., logging or showing an alert
                print("Error fetching restaurant list: \(error.localizedDescription)")
            }
        }
    }
    
    func convertRestaurantListToRestaurantListCell(restaurantList: [RestaurantData]) {
        var restaurantCellModelList: [RestaurantListCellModel] = []
        for restaurant in restaurantList {
            let restaurantCellModel = RestaurantListCellModel(
                restaurantImageURL: restaurant.imageURL,
                restaurantName: restaurant.name,
                cuisineName: restaurant.cuisine
            )
            restaurantCellModelList.append(restaurantCellModel)
        }
        restaurantListCellModel = restaurantCellModelList
    }
    
    func convertCuisineList(from restaurantList: [RestaurantData]) {
        var cuisineCellList: [CuisineListCellModel] = []
        for restaurant in restaurantList {
            let cuisineModel = CuisineListCellModel(cuisineImageURL: restaurant.cuisineImageURL, cuisineName: restaurant.cuisine)
            
            // Check if cuisineModel is already in the list
            if cuisineCellList.first(where: { $0.cuisineName == restaurant.cuisine }) == nil {
                // Belum ada yang sama
                cuisineCellList.append(cuisineModel)
            }
        }
        cuisineList = cuisineCellList
    }
}
