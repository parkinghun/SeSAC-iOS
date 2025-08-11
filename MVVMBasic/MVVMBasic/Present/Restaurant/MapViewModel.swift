//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/11/25.
//

import Foundation

final class MapViewModel {
    private(set) var list = RestaurantList.restaurantArray
    
    let inputAllMenuAction = Observable(())
    let inputKoreanMenuAction = Observable(())
    let inputWesternMenuAction = Observable(())
    
    private(set) var outputRestaurantList: Observable<[Restaurant]> = Observable([])
    
    init() {
        // 이것도 계선 가능할 듯..?
        inputAllMenuAction.lazyBind { [weak self] _ in
            guard let self else { return }
            outputRestaurantList.value = allMenuAction(list)
        }
        inputKoreanMenuAction.lazyBind { [weak self] _ in
            guard let self else { return }
            outputRestaurantList.value = koreanMenuAction(list)
        }
        inputWesternMenuAction.lazyBind { [weak self] _ in
            guard let self else { return }
            outputRestaurantList.value = westernMenuAction(list)
        }
    }
}

private extension MapViewModel {
    func allMenuAction(_ list: [Restaurant]) -> [Restaurant] {
        return list
    }
    func koreanMenuAction(_ list: [Restaurant]) -> [Restaurant] {
        return list.filter { $0.category == .korean }
    }
    func westernMenuAction(_ list: [Restaurant]) -> [Restaurant] {
        return list.filter { $0.category == .western }
    }
}
