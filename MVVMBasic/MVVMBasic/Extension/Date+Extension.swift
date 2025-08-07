//
//  Date+Extension.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/7/25.
//

import Foundation

extension Date {
    var onlyDate: Date {
        let component = Calendar.current.dateComponents([.year, .month,. day], from: self)
        return Calendar.current.date(from: component) ?? .now
    }
}
