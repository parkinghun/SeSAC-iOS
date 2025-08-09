//
//  Calendar+Extension.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/7/25.
//

import Foundation

extension Calendar {
    func getDateGap(from: Date, to: Date = .now) -> Int? {
        let calendar = Calendar.current
        let dayDifference = calendar.dateComponents([.day], from: from, to: to)
//        guard let dayDifference = components.day else { return nil }
        
        return dayDifference.day
    }
    
//    func getDateFromStringDate(year: String, month: String, day: String) -> Date? {
//        var calendar = Calendar.current
//        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
//        
//        var components = DateComponents()
//        components.year = Int(year)
//        components.month = Int(month)
//        components.day = Int(day)
//
//        let date = calendar.date(from: components)
//        return date
//    }
}
