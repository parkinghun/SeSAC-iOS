//
//  UILabel+Extension.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

extension UILabel {
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    func configure(text: String? = nil, font: UIFont? = nil, color: UIColor? = nil, bgColor: UIColor? = nil, alignment: NSTextAlignment = .natural, numberOfLines: Int? = nil) {
        if let text { self.text = text }
        if let font { self.font = font }
        if let color { self.textColor = color }
        if let bgColor { self.backgroundColor = bgColor }
        self.textAlignment = alignment
        if let numberOfLines { self.numberOfLines = numberOfLines }
    }
}
