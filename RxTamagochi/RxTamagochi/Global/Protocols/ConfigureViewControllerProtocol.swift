//
//  ConfigureViewController.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/23/25.
//

import UIKit

protocol ConfigureViewControllerProtocol: AnyObject {
    func setupNavigationBackButtonStyle()
}

extension ConfigureViewControllerProtocol where Self: UIViewController {
    func setupNavigationBackButtonStyle() {
        self.navigationItem.backButtonDisplayMode = .minimal
    }
    
    func configureBackgroundColor() {
        view.backgroundColor = UIColor(hexCode: "#DCF6FC")
    }
}

