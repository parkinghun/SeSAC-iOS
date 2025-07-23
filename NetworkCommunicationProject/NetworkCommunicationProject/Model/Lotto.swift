//
//  Lotto.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

struct LottoManager {
    private let lottoCount = 7
    let latestRound = 1181

    
    var rounds: [Int] {
        return Array(1...latestRound)
    }
    
    func generateNumbers() -> [LottoNumber] {
        let randomNumbers = (1...45).shuffled().prefix(lottoCount).sorted()
        return randomNumbers.map { LottoNumber(number: $0) }
    }

}

struct LottoNumber {
    let number: Int
    var color: UIColor {
        switch number {
        case 1...10: return .orange
        case 11...20: return .blue
        case 21...30: return .red
        case 31...40: return .gray
        case 41...45: return .green
        default: return .black
        }
    }
}
