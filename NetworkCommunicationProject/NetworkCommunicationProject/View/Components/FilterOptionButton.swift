//
//  CustomButton.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/26/25.
//

import UIKit

final class FilterOptionButton: UIButton {
    
    convenience init(title: String, foregroundColor: UIColor = .white, backgroundColor: UIColor = .black) {
        if #available(iOS 15.0, *) {  // iOS 15 이상은 Configuration 이용해서 버튼 설정
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
        } else {  //iOS 15 이전 버전은 Configuration이 없으므로 이전의 방식으로 버튼 설정
            self.init(type: .custom)
            
            self.setTitle(title, for: .normal)
            self.setTitleColor(foregroundColor, for: .normal)
            self.backgroundColor = backgroundColor
            self.layer.cornerRadius = 8
            self.clipsToBounds = true
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 1
            self.titleEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        }
    }
}

