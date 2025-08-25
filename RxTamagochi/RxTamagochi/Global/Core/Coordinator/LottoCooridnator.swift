//
//  LottoCooridnator.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit

final class LottoCooridnator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    let nav: BaseNavigationController

    init(nav: BaseNavigationController) {
        self.nav = nav
    }
    
    func start() {
        let vc = LottoViewController()
        nav.setViewControllers([vc], animated: true)
    }
    
    func stop() { }
}
