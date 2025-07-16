//
//  UILabel+Extension.swift
//  TravelProject
//
//  Created by 박성훈 on 7/16/25.
//

import UIKit

extension UILabel {
    func configure(text: String? = nil, font: UIFont? = nil, color: UIColor? = nil, alignment: NSTextAlignment? = nil, numberOfLines: Int = 1) {
        if let text { self.text = text}
        if let font { self.font = font }
        if let color { self.textColor = color }
        if let alignment { self.textAlignment = alignment }
        
    }
    
    func asFontColor(targetString: String, color: UIColor = .yellow) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: targetString, options: .caseInsensitive)
        
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        attributedText = attributedString
    }
}
