//
//  DateExtension.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import Foundation

extension Date {
    static var simplaFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
}
