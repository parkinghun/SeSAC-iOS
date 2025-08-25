//
//  BoxOfficeCoordinator.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import Foundation

final class BoxOfficeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    let nav: BaseNavigationController
    
    init(nav: BaseNavigationController) {
        self.nav = nav
    }
    
    func start() {
        let vc = BoxOfficeViewController()
        vc.tabBarItem = TabBarType.boxOffice.tabBarItem
        nav.setViewControllers([vc], animated: true)
    }
    
    func stop() { }
}
