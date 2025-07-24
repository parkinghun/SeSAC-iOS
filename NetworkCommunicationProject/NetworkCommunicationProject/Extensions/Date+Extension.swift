//
//  Date+Extension.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        return DateFormatter.simpleDateFormatter.string(from: self)
    }
}
