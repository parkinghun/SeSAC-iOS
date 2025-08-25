//
//  BaseNavigationController.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/23/25.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        configureNavigationBar()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureNavigationBar()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backButtonDisplayMode = .minimal
        super.pushViewController(viewController, animated: animated)
    }
    
}

private extension BaseNavigationController {
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hexCode: "#DCF6FC")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationBar.tintColor = .black
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
