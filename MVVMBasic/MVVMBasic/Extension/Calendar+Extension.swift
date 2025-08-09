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
        
        return dayDifference.day
    }
}
