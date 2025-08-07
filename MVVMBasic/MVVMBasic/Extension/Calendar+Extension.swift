//
//  Calendar+Extension.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/7/25.
//

import Foundation

extension Calendar {
    func getDateGap(from: Date, to: Date) -> Int {
        let fromDateOnly = from.onlyDate
        let toDateOnly = to.onlyDate
        return self.dateComponents([.day], from: fromDateOnly, to: toDateOnly).day ?? 0
    }
}
