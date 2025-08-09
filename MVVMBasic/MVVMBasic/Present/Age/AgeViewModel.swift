//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import Foundation

final class AgeViewModel {
    private var ageLimit = (0...100)
    var inputAge: String? = "" {
        didSet {
            getOutputText()
        }
    }
    
    var closure: (() -> Void)?
    
    var outputText = "" {
        didSet {
            closure?()
        }
    }
    
    private func getOutputText() {
        do {
            guard let input = inputAge else { return }
            
            let age = try validateAgeInput(text: input)
            outputText = age
        } catch let error {
            print(error.localizedDescription)
            outputText = error.message
        }
    }
    
    private func validateAgeInput(text: String) throws(AgeValidationError) -> String {
        guard !text.isEmpty else {
            throw .blankSpace
        }
        
        guard let age = Int(text) else {
            throw .isNotInt
        }
        
        guard ageLimit.contains(age) else {
            throw .outOfRange
        }
        
        return text
    }
}

extension AgeViewModel {
    enum AgeValidationError: Error {
        case outOfRange
        case blankSpace
        case isNotInt
        
        var message: String {
            switch self {
            case .outOfRange:
                return "입력하신 내용이 범위를 벗어났습니다. \n1~100세까지 입력해주세요."
            case .blankSpace:
                return "빈 문자를 입력하셨습니다. \n나이를 입력해주세요."
            case .isNotInt:
                return "숫자가 아닙니다. \n나이를 입력해주세요."
            }
        }
    }
}
