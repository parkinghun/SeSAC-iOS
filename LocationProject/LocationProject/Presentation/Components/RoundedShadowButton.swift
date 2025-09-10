//
//  CircledButton.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import UIKit
import SnapKit

final class RoundedShadowButton: BaseButton {
    
    override func configure() {
        super.configure()
        backgroundColor = .white
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray2.cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)  /// 그림자와 해당 View와의 거리 (width는 x좌표, height는 y좌표)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0 /// 그림자의 크기
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
