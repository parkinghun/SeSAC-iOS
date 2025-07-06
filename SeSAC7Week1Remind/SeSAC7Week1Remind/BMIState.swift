//
//  BMIState.swift
//  SeSAC7Week1Remind
//
//  Created by 박성훈 on 7/5/25.
//

import UIKit

struct BMIState {
    let description: String
    let color: UIColor
    
    static func getState(for bmi: Double) -> BMIState {
        switch bmi {
        case ..<18.5:
            return BMIState(description: "저체중", color: .green)
        case 18.5..<23:
            return BMIState(description: "정상", color: .blue)
        case 23..<25:
            return BMIState(description: "비만 전단계", color: .orange)
        case 25..<30:
            return BMIState(description: "1단계 비만", color: .red)
        case 30..<35:
            return BMIState(description: "2단계 비만", color: .red)
        case 35...:
            return BMIState(description: "3단계 비만", color: .red)
        default:
            return BMIState(description: "알 수 없음", color: .gray)
        }
    }
}
