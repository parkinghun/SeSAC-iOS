//
//  DateFormatter+Extension.swift
//  TravelProject
//
//  Created by 박성훈 on 7/14/25.
//

import Foundation

extension DateFormatter {
    static let compactDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static let krDateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}

