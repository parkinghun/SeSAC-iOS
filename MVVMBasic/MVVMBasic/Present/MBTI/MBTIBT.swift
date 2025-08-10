//
//  BMTIBT.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import UIKit

final class MBTIButton: UIButton {
    
    convenience init() {
        self.init(frame: .zero)
        self.setTitleColor(UIColor.lightGray, for: .normal)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
    }
}
