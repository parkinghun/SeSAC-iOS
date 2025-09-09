//
//  DateFormatter+Extension.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import Foundation

extension DateFormatter {
    static let basic: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 a H시 m분"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
