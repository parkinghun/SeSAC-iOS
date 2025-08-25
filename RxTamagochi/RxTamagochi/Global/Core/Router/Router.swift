//
//  Router.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import UIKit

final class Router: Routable {
    private weak var nav: BaseNavigationController?
    
    init(nav: BaseNavigationController) {
        self.nav = nav
    }
    
    func setRoot(_ vc: UIViewController, animated: Bool) {
        nav?.setViewControllers([vc], animated: animated)
    }
    
    func push(_ vc: UIViewController, animated: Bool) {
        nav?.pushViewController(vc, animated: animated)
    }
    
    func present(_ vc: UIViewController, animated: Bool) {
        nav?.present(vc, animated: animated)
    }
    
    func pop(animated: Bool) {
        nav?.popViewController(animated: animated)
    }
    
}
