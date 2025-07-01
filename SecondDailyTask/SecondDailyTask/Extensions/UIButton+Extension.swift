//
//  UIButton+Extension.swift
//  SecondDailyTask
//
//  Created by 박성훈 on 7/1/25.
//

import UIKit

extension UIButton {
    func setUI(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.contentVerticalAlignment = .bottom
    }
}
