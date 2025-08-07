//
//  DateFormatter+Extension.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/7/25.
//

import Foundation

extension DateFormatter {
    static var simpleFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter
    }
}
