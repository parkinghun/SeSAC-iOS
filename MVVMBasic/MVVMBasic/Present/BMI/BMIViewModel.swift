//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import Foundation

final class BMIViewModel {
    typealias BMIResult = Result<String, BMIValidationError>
    var closure: (() -> Void)?

    var inputBMI = BMI(height: "", weight: "") {
        didSet {
            result = getBMIResult()
        }
    }
    
    var outputText = ""
    var outputShowAlert = false
    
    private var result: BMIResult = .success("") {
        didSet {
            setupOutput(result: result)
            closure?()
        }
    }
    
    private func setupOutput(result: BMIResult) {
        do {
            outputText = try result.get()
            outputShowAlert = false
        } catch let error {
            outputText = error.message
            outputShowAlert = true
        }
    }
    
    private func getBMIResult() -> BMIResult {
        do {
            let input = try validateBMIInput()
            let bmi = inputBMI.getBmi(height: input.height, weight: input.weight)
            let state = inputBMI.getBMIState(bmi: bmi)
            
            return .success("BMI 지수: \(bmi) \n\(state)")
        } catch let error {
            return .failure(error)
        }
    }
    
    private func validateBMIInput() throws(BMIValidationError) -> (height: Double, weight: Double) {
        guard let height = inputBMI.height,
              let weight  = inputBMI.weight else {
            throw .invalidInput
        }
        
        guard !height.isEmpty, !weight.isEmpty else {
            throw .blankSpace
        }

        guard let height = Double(height),
              let weight = Double(weight) else {
            throw .isNotDouble
        }

        guard height >= inputBMI.heightLimit.min,
              height <= inputBMI.heightLimit.max else {
            throw .outOfRangeHeight
        }
        
        guard weight >= inputBMI.weightLimit.min,
              weight <= inputBMI.heightLimit.max else {
            throw .outOfRangeWeight
        }
        
        return (height, weight)
    }
}

extension BMIViewModel {
    struct BMI {
        var height: String?
        var weight: String?
        
        var heightLimit: (min: Double, max: Double) {
            return (80, 230)
        }
        
        var weightLimit: (min: Double, max: Double) {
            return (20, 160)
        }
 
        func getBmi(height: Double, weight: Double) -> Double {
            var bmi = weight / (height * height) * 10000
            bmi = round(bmi * 10) / 10
            print("BMI결과값: \(bmi)")
            return bmi
        }
        
        func getBMIState(bmi: Double) -> String {
            switch bmi {
            case ..<18.6:
                return "저체중"
            case 18.6..<23.0:
                return "표준"
            case 23.0..<25.0:
                return "과제중"
            case 25.0..<30.0:
                return "중도비만"
            case 30.0...:
                return "고도비만"
            default:
                return ""
            }
        }
    }
    
    enum BMIValidationError: Error {
        case outOfRangeHeight
        case outOfRangeWeight
        case isNotDouble
        case blankSpace
        case invalidInput
        
        var message: String {
            switch self {
            case .outOfRangeHeight:
                return "입력하신 정보가 키의 범위를 벗어났습니다."
            case .outOfRangeWeight:
                return "입력하신 정보가 몸무게의 범위를 벗어났습니다."
            case .isNotDouble:
                return "숫자가 아닙니다. 키와 몸무게를 입력해주세요."
            case .blankSpace:
                return "키와 몸무게 모두 입력해주세요."
            case .invalidInput:
                return "키와 몸무게를 잘못입력하셨습니다. 다시 입력해주세요."
            }
        }
    }
}
