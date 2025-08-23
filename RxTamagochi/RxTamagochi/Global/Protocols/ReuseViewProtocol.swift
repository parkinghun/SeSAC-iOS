//
//  ReuseViewProtocol.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/22/25.
//

import Foundation

protocol ReuseViewProtocol {
    static var identifier: String { get }
}

extension ReuseViewProtocol {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
