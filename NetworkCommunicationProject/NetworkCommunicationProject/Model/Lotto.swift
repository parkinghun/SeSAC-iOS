//
//  Lotto.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

struct Lotto: Decodable {
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

struct LottoBall {
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
