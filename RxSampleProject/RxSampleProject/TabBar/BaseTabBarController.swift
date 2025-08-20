//
//  BaseTabBarController.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/19/25.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setTabBar()
    }
    
    private func setTabBar() {
        self.viewControllers = TabBarType.allCases.map { $0.viewController }
        
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .systemGray
    }
}
