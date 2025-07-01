//
//  UILabel+Extension.swift
//  SecondDailyTask
//
//  Created by 박성훈 on 7/1/25.
//

import UIKit

extension UILabel {
    func setUI(text: String) {
        self.text = text
        self.font = .systemFont(ofSize: 12)
        self.textAlignment = .right
        self.textColor = .white
    }
}
