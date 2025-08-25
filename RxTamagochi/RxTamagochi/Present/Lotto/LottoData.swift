//
//  LottoData.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/26/25.
//

import Foundation

struct LottoData {
    var result: String
    
    init(lotto: Lotto) {
        let numbers = [lotto.drwtNo1, lotto.drwtNo2, lotto.drwtNo3, lotto.drwtNo4, lotto.drwtNo5, lotto.drwtNo6]
        
        let numberString = numbers.map { String($0) }.joined(separator: ", ")
        self.result = "\(numberString) + 보너스: \(lotto.bnusNo)"
    }
}
