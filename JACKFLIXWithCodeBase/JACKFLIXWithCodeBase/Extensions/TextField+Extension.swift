//
//  TextField+Extension.swift
//  JACKFLIXWithCodeBase
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit

extension UITextField {
    
    static func makeConfigured(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.configure(placeholder: placeholder, alignment: .center, bgColor: .lightGray, cornerRadius: DesignSystem.Radius.medium)
        return tf
    }
    
    func configure(placeholder: String? = nil, alignment: NSTextAlignment? = nil, bgColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        if let placeholder { self.placeholder = placeholder }
        if let alignment { self.textAlignment = alignment }
        if let bgColor { self.backgroundColor = bgColor }
        if let cornerRadius { self.setCorner(radius: cornerRadius) }
    }
}
