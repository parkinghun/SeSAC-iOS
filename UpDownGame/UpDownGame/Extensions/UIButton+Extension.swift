//
//  UIButton+Extension.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit

extension UIButton {
    func configure(title: String) {
        self.configure(title: title, color: .white, bgColor: .black)
    }
    
    func configure(title: String, color: UIColor, bgColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.backgroundColor = bgColor
    }
}
