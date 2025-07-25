//
//  NumberFormatter+Extension.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import Foundation

extension NumberFormatter {
    static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
