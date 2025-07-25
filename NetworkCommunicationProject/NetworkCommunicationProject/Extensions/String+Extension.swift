//
//  String+Extension.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/24/25.
//

import Foundation

extension String {
    func toFormattedDate() -> String? {
        guard let date = DateFormatter.simpleDateFormatter.date(from: self) else {
            return nil
        }
        
        return DateFormatter.dateOnlyFormatter.string(from: date)
    }
    
    func toFormattedDecimal() -> String? {
        guard let decimal = NumberFormatter.decimalFormatter.string(for: self) else {
            return nil
        }
        
        return decimal
    }
}
