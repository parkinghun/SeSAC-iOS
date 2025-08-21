//
//  BaseNavigationController.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/20/25.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
   
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationBar.tintColor = .black
        navigationBar.standardAppearance = appearance
        navigationItem.backButtonDisplayMode = .minimal
    }
}
