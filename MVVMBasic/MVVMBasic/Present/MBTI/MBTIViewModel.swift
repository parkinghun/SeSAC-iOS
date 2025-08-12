//
//  MBTIViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import Foundation

final class MBTIViewModel {
    
    private let imageIndex = Array(1...12)
    var randomImageName: String {
        let imageNumber = imageIndex.randomElement()
        return "image\(imageNumber ?? 0)"
    }
    var allImageName: [String] {
        return imageIndex.map { "image\($0)" }
    }
    
    var selectedEnergy: EnergyType?
    var selectedPerception: PerceptionType?
    var selectedJudgment: JudgmentType?
    var selectedLifeStyle: LifestyleType?
    
    var inputNickname: String? {
        didSet {
            do {
                let _ = try checkNicknameValidity()
            } catch {
                
            }
        }
    }
    // 1. MBTI 4개 모두 선택이 되어있어야 함
    // 2. 닉네임도 세팅이 되어야 완료버튼 기능
    
    var outputState: String = "" {
        didSet {
            // closure(매개변수는 스트링)
        }
    }
    
    
    // 버튼 터치시
    func mbtiButtonTapped<T: RawRepresentable & CaseIterable>(caseValue: T) {
        switch caseValue {
        case let energy as MBTIViewModel.EnergyType:
            print("EnergyType 눌림: \(energy.rawValue)")
        case let perception as MBTIViewModel.PerceptionType:
            print("PerceptionType 눌림: \(perception.rawValue)")
        case let judgment as MBTIViewModel.JudgmentType:
            print("JudgmentType 눌림: \(judgment.rawValue)")
        case let lifeStyle as MBTIViewModel.LifestyleType:
            print("LifestyleType 눌림: \(lifeStyle.rawValue)")
        default: break
        }
    }
    
    private func checkNicknameValidity() throws(NicknameInputError) {
        guard let nickname = inputNickname else { return }
        
        guard (0...10).contains(nickname.count) else {
            throw .outOfRange
        }
        
        let specialCharacters = "[@#$%]"
        guard let _ = nickname.range(of: specialCharacters, options: .regularExpression) else {
            throw .containsSpecialChars
        }
        
        let numbers = "[0-9]"
        guard let _ = nickname.range(of: numbers, options: .regularExpression) else {
            throw .containsNumbers
        }
    }
    
    private func dd() {
        // 조건 맞으면 #186FF2 -> 이건 분기처리해주면 뷰에서 바꿀 부분
        
        // TextField 없으면 닉네임 숨김 -> Bool
        // 조건 맞으면 사용할 수 있는 닉네임이에요
        // 글자수 안맞으면
    }
}

extension MBTIViewModel {
     
    
    enum EnergyType: String, CaseIterable {
        case e = "E"
        case i = "I"
    }
    
    enum PerceptionType: String, CaseIterable {
        case s = "S"
        case n = "N"
    }
    
    enum JudgmentType: String, CaseIterable {
        case t = "T"
        case f = "F"
    }
    
    enum LifestyleType: String, CaseIterable {
        case j = "J"
        case p = "P"
    }
}

extension MBTIViewModel {
    enum NicknameInputError: Error {
        case outOfRange
        case containsSpecialChars
        case containsNumbers
        
        var message: String {
            switch self {
            case .outOfRange:
                return "2글자 이상 10글자 미만으로 설정해주세요"
            case .containsSpecialChars:
                return "닉네임에 @, #, $, % 는 포함할 수 없어요"
            case .containsNumbers:
                return "닉네임에 숫자는 포함할 수 없어요"
            }
        }
    }
}
