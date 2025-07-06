//
//  BMIError.swift
//  SeSAC7Week1Remind
//
//  Created by 박성훈 on 7/5/25.
//

import Foundation

enum BMIInputError {
    case incompleteInput  // 키 또는 몸무게 중 입력 안한 것이 있을 때
    case invalidRange  // 키 또는 몸무게 범위가 비정상적일 때
    case nonNumericInput  // 숫자가 아닌 값 입력(문자 or 공백)
    case emptyInput  // 아무것도 입력하지 않음 (공백 포함)
    
    var message: String {
        switch self {
        case .incompleteInput:
            return "키와 몸무게 모두 입력해주세요."
        case .invalidRange:
            return "입력 값이 올바른 범위인지 확인해주세요.(0~300)"
        case .nonNumericInput:
            return "숫자만 입력해주세요."
        case .emptyInput:
            return "공백 혹은 빈칸이 아닌 숫자를 입력해주세요."

        }
    }
    
    var title: String {
        return "BMI 입력 오류"
    }
}
