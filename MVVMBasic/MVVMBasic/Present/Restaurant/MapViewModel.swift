//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/11/25.
//

import Foundation

final class MapViewModel {
    private(set) var list = RestaurantList.restaurantArray
    
    let inputActionSheetAction: Observable<Restaurant.RestaurantType> = Observable(.all)
    
    private(set) var outputRestaurantList: Observable<[Restaurant]> = Observable([])
    
    init() {
        inputActionSheetAction.lazyBind { [weak self] type in
            guard let self else { return }
            outputRestaurantList.value = getFilteredRestaurantList(for: list, to: type)
        }
    }
}

private extension MapViewModel {
    func getFilteredRestaurantList(for list: [Restaurant], to type: Restaurant.RestaurantType) -> [Restaurant] {
        switch type {
        case .all: return list
        default: return list.filter { $0.category == type }
        }
    }
}
