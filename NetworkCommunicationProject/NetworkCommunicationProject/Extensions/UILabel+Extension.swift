//
//  UILabel+Extension.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

extension UILabel {
    
    func configure(text: String? = nil, font: UIFont? = nil, color: UIColor? = nil, bgColor: UIColor? = nil, alignment: NSTextAlignment = .natural) {
        if let text { self.text = text }
        if let font { self.font = font }
        if let color { self.textColor = color }
        if let bgColor { self.backgroundColor = bgColor }
        self.textAlignment = alignment
    }
}
