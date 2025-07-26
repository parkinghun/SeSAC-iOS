//
//  CustomButton.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/26/25.
//

import UIKit

final class FilterOptionButton: UIButton {
    convenience init(title: String, titleColor: UIColor = .white , backgroundColor: UIColor = .black, cornerRadius: CGFloat = 8) {
        self.init(type: .custom)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }
}
