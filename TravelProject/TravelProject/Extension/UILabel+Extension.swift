//
//  UILabel+Extension.swift
//  TravelProject
//
//  Created by 박성훈 on 7/16/25.
//

import UIKit

extension UILabel {
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
