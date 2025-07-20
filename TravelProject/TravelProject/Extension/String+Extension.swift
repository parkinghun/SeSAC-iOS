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
    
    func toFormattedShortDate() -> String? {
        guard let date = DateFormatter.hourDateFormatter.date(from: self) else {
            return nil
        }
        
        return DateFormatter.shortDateFormatter.string(from: date)
    }
    
    func toFormattedTime() -> String? {
        guard let date = DateFormatter.hourDateFormatter.date(from: self) else {
            return nil
        }
        
        return DateFormatter.timeDateFormatter.string(from: date)
    }
}
