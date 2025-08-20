//
//  TabBarType.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/19/25.
//

import UIKit

enum TabBarType: CaseIterable {
    case tableView
    case numbers
    case validation
    case home
    
//    var navigationController: UINavigationController {
//        return BaseNavigationController(rootViewController: viewController)
//    }
    
    var viewController: UIViewController {
        switch self {
        case .tableView:
            let vc = SimpleTableViewController()
            vc.tabBarItem = self.tabBarItem
            return vc
        case .numbers:
            let vc = NumbersViewController()
            vc.tabBarItem = self.tabBarItem
            return vc
        case .validation:
            let vc = SimpleValidationViewController()
            vc.tabBarItem = self.tabBarItem
            return vc
        case .home:
            let vc = HomeworkViewController()
            vc.tabBarItem = self.tabBarItem
            return vc
        }
    }
    
    private var tabBarItem: UITabBarItem {
        switch self {
        case .tableView:
            return UITabBarItem(title: "테이블뷰", image: itemImage, tag: 0)
        case .numbers:
            return UITabBarItem(title: "넘버", image: itemImage, tag: 1)
        case .validation:
            return UITabBarItem(title: "유효성", image: itemImage, tag: 2)
        case .home:
            return UITabBarItem(title: "홈", image: itemImage, tag: 3)
        }
    }
    
    private var itemImage: UIImage? {
        switch self {
        case .tableView:
            return UIImage(systemName: "tablecells")
        case .numbers:
            return UIImage(systemName: "numbers")
        case .validation:
            return UIImage(systemName: "text.page.badge.magnifyingglass")
        case .home:
            return UIImage(systemName: "house")
        }
    }
}
