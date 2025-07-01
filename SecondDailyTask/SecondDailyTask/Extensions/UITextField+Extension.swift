//
//  UITextField+Extension.swift
//  SecondDailyTask
//
//  Created by 박성훈 on 7/1/25.
//

import UIKit

extension UITextField {
    func setUI(placeholder: String?, isSecure: Bool = false, keyboardType: UIKeyboardType = .default) {
        self.placeholder = placeholder
        self.textColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.textAlignment = .center
        self.setPlaceholder(color: .systemGray4)
        self.isSecureTextEntry = isSecure
        self.backgroundColor = .darkGray
        self.keyboardType = keyboardType
    }
    
    func setPlaceholder(color: UIColor = .gray) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
