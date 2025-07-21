//
//  UIView+Extension.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit

extension UIView {
    func setCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

