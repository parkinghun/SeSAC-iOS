//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import Foundation

final class AgeViewModel {
    private var ageLimit = (0...100)
    typealias AgeResult = Result<String, AgeValidationError>
    
    // MARK: - VC에서 들어온 데이터
    // 처음 들어올 때 빈값에 대한 에러를 리턴해서
    // 옵셔널 값을 주어서 nil에 대한 핸들링을 따로 하게 만들었음
    var inputAge: Observable<String?> = Observable(nil)
    
    // MARK: - View에서 바라보는 데이터
    // Result를 처리해서 String으로 주는 것까지가 뷰모델의 역할이 아닐까?
    var outputText = Observable("")
    
    init() {
        print("AgeViewModel - init")
        // init 시점부터 failure를 뱉음
        // 원하는 동작은 클릭 버튼 이후 시점부터임 -> init에서 호출되면 안되는 듯
        // Observable의 bind 자체가 호출될 때 실행하기 때문에 원하는 결과가 안나옴
        // 해결방법 1. nil 일 때??
        inputAge.bind { [weak self] _ in
            guard let self else { return }
            
            validationCheckLabel()  // 이게 클로저로 할당됨
        }
    }
}

private extension AgeViewModel {
    func validationCheckLabel() {
        let result = validateAgeInput()
        
        switch result {
        case .success(let value):
            outputText.value = value
        case .failure(let error):
            outputText.value = error.message
        }
    }
    
    func validateAgeInput() -> AgeResult {
        
        guard let value = inputAge.value else {
            return .failure(.invalidError)
        }
        
        guard !value.isEmpty else {
            return .failure(.blankSpace)
        }
        
        guard let age = Int(value) else {
            return .failure(.isNotInt)
        }
        
        guard ageLimit.contains(age) else {
            return .failure(.outOfRange)
        }
        
        return .success(value)
    }
}

extension AgeViewModel {
    enum AgeValidationError: Error {
        case invalidError
        case outOfRange
        case blankSpace
        case isNotInt
        
        var message: String {
            switch self {
            case .invalidError:
                return ""
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
