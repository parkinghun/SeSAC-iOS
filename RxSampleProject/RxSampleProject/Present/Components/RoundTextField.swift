//
//  roundTextField.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/19/25.
//

import UIKit

final class RoundTextField: UITextField {
    convenience init(text: String, alignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        self.text = text
        self.font = .systemFont(ofSize: 14)
        self.textAlignment = alignment
        self.borderStyle = .roundedRect
    }
}
