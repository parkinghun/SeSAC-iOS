//
//  TabBarCoordinator.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    let tabBarController = BaseTabBarController()
    private let store: TamagochiStore
    private let tabs = TabBarType.allCases
    
    init(store: TamagochiStore) {
        self.store = store
    }
    
    func start() {
        let navs: [UINavigationController] = tabs.map { type in
            let nav = BaseNavigationController()
            
            switch type {
            case .tamagochi:
                let coordinator = MainCoordinator(nav: nav, store: store)
                childCoordinators.append(coordinator)
                coordinator.start()
            case .lotto:
                let coordinator = LottoCooridnator(nav: nav)
                childCoordinators.append(coordinator)
                coordinator.start()
            case .boxOffice:
                let coordinator = BoxOfficeCoordinator(nav: nav)
                childCoordinators.append(coordinator)
                coordinator.start()
            }
            
            return nav
        }
        
        tabBarController.setViewControllers(navs, animated: true)
        tabBarController.selectedIndex = TabBarType.tamagochi.rawValue
    }
    
    func stop() {
        childCoordinators.removeAll()
    }
}
