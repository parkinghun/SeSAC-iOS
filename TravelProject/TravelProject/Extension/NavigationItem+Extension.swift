//
//  NavigationItem+Extension.swift
//  TravelProject
//
//  Created by 박성훈 on 7/20/25.
//

import UIKit

extension UINavigationItem {
    
    func setupWithBackButton(title: String) {
        self.title = title
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .gray
        self.backBarButtonItem = backBarButtonItem
    }
}
