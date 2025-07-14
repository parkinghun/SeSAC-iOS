//
//  String+Extension.swift
//  TravelProject
//
//  Created by 박성훈 on 7/14/25.
//

import Foundation

extension String {
    func toFormattedDate() -> String? {
        guard let date = DateFormatter.compactDateFormatter.date(from: self) else {
            return nil
        }
        
        return DateFormatter.krDateFormatter.string(from: date)
    }
}
