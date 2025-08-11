//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import Foundation

final class BMIViewModel {
    typealias BMIResult = Result<String, BMIValidationError>
    
    // 값을 튜플로 한 번에 받아 inputBMI의 바인드를 여러번 호출하는 것을 방지
    var inputTexts: Observable<(String?, String?)> = Observable(("", ""))
    private var inputBMI = Observable(BMI(height: "", weight: ""))
    
    var outputResult = Observable(BMIResult.success(""))
    
    init() {
        inputTexts.lazyBind { [weak self] (height, weight) in
            guard let self, let height, let weight else { return }
            
            inputBMI.value = .init(height: height, weight: weight)
        }
        inputBMI.lazyBind { [weak self] value in
            guard let self else { return }
            getBMIResult(bmi: inputBMI.value)
        }
    }
}

private extension BMIViewModel {
    func getBMIResult(bmi: BMI) {
        do {
            let bmiTuple = try validateBMIInput(bmi: bmi)
            
            let bmiIndex = bmi.getBmi(height: bmiTuple.height, weight: bmiTuple.weight)
            let state = bmi.getBMIState(bmi: bmiIndex)
            
            outputResult.value = .success("BMI 지수: \(bmiIndex) \n\(state)")
        } catch let error {
            outputResult.value = .failure(error)
        }
    }
    
    func validateBMIInput(bmi: BMI) throws(BMIValidationError) -> (height: Double, weight: Double) {
        let height = bmi.height
        let weight = bmi.weight
        
        guard !height.isEmpty, !weight.isEmpty else {
            throw .blankSpace
        }
        
        guard let height = Double(height),
              let weight = Double(weight) else {
            throw .isNotDouble
        }
        
        guard (bmi.heightLimit.min...bmi.heightLimit.max).contains(height) else {
            throw .outOfRangeHeight
        }
        
        guard (bmi.weightLimit.min...bmi.weightLimit.max).contains(weight) else {
            throw .outOfRangeWeight
        }
        
        return (height, weight)
    }
}

// 사실은 모델 영역인듯
extension BMIViewModel {
    struct BMI {
        var height: String
        var weight: String
        
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
