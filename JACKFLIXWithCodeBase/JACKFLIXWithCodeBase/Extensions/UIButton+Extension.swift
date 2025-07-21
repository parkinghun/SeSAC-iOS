//
//  UIButton+Extension.swift
//  JACKFLIXWithCodeBase
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit

extension UIButton {
    func configure(title: String? = nil, titleColor: UIColor? = nil, image: UIImage? = nil, tintColor: UIColor? = nil, bgColor: UIColor? = nil, corderRadius: CGFloat? = nil) {
        if let title { self.setTitle(title, for: .normal) }
        if let titleColor { self.setTitleColor(titleColor, for: .normal) }
        if let image { self.setImage(image, for: .normal) }
        if let tintColor { self.tintColor = tintColor }
        if let bgColor { self.backgroundColor = bgColor }
        if let corderRadius { self.setCorner(radius: corderRadius) }
    }
}
