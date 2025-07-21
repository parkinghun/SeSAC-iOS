//
//  UILabel+Extension.swift
//  JACKFLIXWithCodeBase
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit

extension UILabel {
    
    func configure(text: String, font: UIFont? = nil, color: UIColor? = nil, bgColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        self.text = text
        
        if let font { self.font = font }
        if let color { self.textColor = color }
        if let bgColor { self.backgroundColor = bgColor }
        if let cornerRadius { self.setCorner(radius: cornerRadius) }
    }
}
