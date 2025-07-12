//
//  String+Extensions.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
//        "220415"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
