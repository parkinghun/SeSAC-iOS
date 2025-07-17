//
//  UIButton+Extension.swift
//  TravelProject
//
//  Created by 박성훈 on 7/17/25.
//

import UIKit

extension UIButton {
    func configure(title: String = "", image: UIImage? = nil, color: UIColor? = nil, bgColor: UIColor? = nil, cornerRadius: CGFloat? = nil) {
        self.setTitle(title, for: .normal)
        
        if let image { self.setImage(image, for: .normal) }
        if let color { self.tintColor = color }
        if let bgColor { self.backgroundColor = bgColor }
        if let cornerRadius { self.setCornerRadius(to: cornerRadius) }
    }
}
