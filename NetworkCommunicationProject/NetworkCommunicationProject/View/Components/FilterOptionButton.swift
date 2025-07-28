//
//  CustomButton.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/26/25.
//

import UIKit

//TODO: - 수정 ㄱㄱ
final class FilterOptionButton: UIButton {
    //    convenience init(title: String, titleColor: UIColor = .white , backgroundColor: UIColor = .black, cornerRadius: CGFloat = 8) {
    //        self.init(type: .custom)
    //        self.setTitle(title, for: .normal)
    //        self.setTitleColor(titleColor, for: .normal)
    //        self.backgroundColor = backgroundColor
    //        self.layer.cornerRadius = cornerRadius
    //        self.clipsToBounds = true
    //        self.layer.borderColor = UIColor.white.cgColor
    //        self.layer.borderWidth = 1
    //    }
    
    convenience init(title: String, foregroundColor: UIColor = .white, backgroundColor: UIColor = .black) {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = foregroundColor
        configuration.baseBackgroundColor = backgroundColor
        
        var attText = AttributedString(title)
        attText.font = UIFont.systemFont(ofSize: 16)
        configuration.attributedTitle = attText
        configuration.background.cornerRadius = 10
        configuration.background.strokeColor = .white
        configuration.buttonSize = .small
        
        self.init(configuration: configuration)
    }
}

