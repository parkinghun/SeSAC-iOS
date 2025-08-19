//
//  BMTIBT.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import UIKit

final class MBTIButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, tag: Int, radius: CGFloat = 22) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.tag = tag
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setSelected(_ selected: Bool) {
        self.backgroundColor = selected ? Colors.btEnabledColor : .clear
        self.setTitleColor(selected ? .white : .lightGray, for: .normal)
        self.layer.borderColor = selected ? Colors.btEnabledColor.cgColor : UIColor.lightGray.cgColor
    }
 
    private func configure() {
        self.setTitleColor(UIColor.lightGray, for: .normal)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
    }
}
