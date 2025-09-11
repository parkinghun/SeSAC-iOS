//
//  ReusableView.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import Foundation

protocol ReusableView {
    static var identifier: String { get }
}

extension ReusableView {
    static var identifier: String { String(describing: Self.self) }
}
