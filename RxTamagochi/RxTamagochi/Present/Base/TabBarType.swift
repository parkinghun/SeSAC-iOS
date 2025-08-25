//
//  TabBarType.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit

enum TabBarType: Int, CaseIterable {
    case tamagochi
    case lotto
    case boxOffice

//
//    var navigationController: UINavigationController {
//        return BaseNavigationController(rootViewController: viewController)
//    }
//    
//    private var viewController: UIViewController {
//        switch self {
//        case .tamagochi:
//            let vc = <#UIViewController#>()
//            vc.tabBarItem = self.tabBarItem
//            return vc
//        case .lotto:
//            let vc = <#UIViewController#>()
//            vc.tabBarItem = self.tabBarItem
//            return vc
//        case .boxOffice:
//            let vc = <#UIViewController#>()
//            vc.tabBarItem = self.tabBarItem
//            return vc
//        }
//    }
    
    private var tabBarItem: UITabBarItem {
        switch self {
        case .tamagochi:
            return UITabBarItem(title: title, image: itemImage, tag: 0)
        case .lotto:
            return UITabBarItem(title: title, image: itemImage, tag: 1)
        case .boxOffice:
            return UITabBarItem(title: title, image: itemImage, tag: 2)
        }
    }
    
    private var title: String? {
        switch self {
        case .tamagochi:
            return "다마고치"
        case .lotto:
            return "로또"
        case .boxOffice:
            return "박스오피스"
        }
    }
    
    private var itemImage: UIImage? {
        switch self {
        case .tamagochi:
            return UIImage(systemName: "gamecontroller")
        case .lotto:
            return UIImage(systemName: "01.circle")
        case .boxOffice:
            return UIImage(systemName: "movieclapper")
        }
    }
}
