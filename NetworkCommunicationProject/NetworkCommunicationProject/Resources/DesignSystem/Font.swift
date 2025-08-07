//
//  Font.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

extension DesignSystem {
    enum Font {
        static let largeTitle = UIFont.systemFont(ofSize: 33, weight: .regular)
        static let title1 = UIFont.systemFont(ofSize: 27, weight: .regular)
        static let title2 = UIFont.systemFont(ofSize: 21, weight: .regular)
        static let title3 = UIFont.systemFont(ofSize: 19, weight: .regular)
        static let title3Bold = UIFont.boldSystemFont(ofSize: 19)
        static let headline = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let body = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let callout = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let subhead = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let footnote = UIFont.systemFont(ofSize: 12, weight: .semibold)
        static let caption1 = UIFont.systemFont(ofSize: 11, weight: .regular)
        static let caption2 = UIFont.systemFont(ofSize: 11, weight: .regular)
    }
}
// 구조체로 만들었을 때랑 어떤 예외처리를 ㅐㅎ야하는지 관점
