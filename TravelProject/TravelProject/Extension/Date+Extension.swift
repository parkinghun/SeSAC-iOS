//
//  Date+Extension.swift
//  TravelProject
//
//  Created by 박성훈 on 7/21/25.
//

import Foundation

extension Date {
    var hourDateString: String {
        return DateFormatter.hourDateFormatter.string(from: .now)
    }
}
