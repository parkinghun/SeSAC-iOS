//
//  MBTIViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import Foundation

final class MBTIViewModel {
    
    struct Input {
        var profileTapped = Observable(())
        var nicknameText: Observable<String?> = Observable(nil)
        var mbtiTapped: Observable<Int?> = Observable(nil)
    }
    
    struct Output {
        private(set) var profileTapped = Observable(())
        private(set) var stateMessage = Observable("")
        private(set) var nicknameValidate = Observable(false)
        //TODO: - Output을 어떤 형식으로 보낼지 고민해보기
        private(set) var tappedButtonIndex: Observable<Int> = Observable(0)
        // 완료버튼 추가
    }
    
    var input: Input
    var output: Output
    
    
    private let imageIndex = Array(1...12)
    var randomImageName: String {
        let imageNumber = imageIndex.randomElement()
        return "image\(imageNumber ?? 0)"
    }
    var allImageName: [String] {
        return imageIndex.map { "image\($0)" }
    }
    
    init() {
        input = Input()
        output = Output()
        
        input.profileTapped.lazyBind { [weak self] _ in
            guard let self else { return }
            output.profileTapped.value = ()
        }
        input.nicknameText.lazyBind { [weak self] value in
            guard let self else { return }
            validation(nickname: value)
        }
        input.mbtiTapped.lazyBind { [weak self] value in
            guard let self, let value else { return }
            print("\(value) 눌림")
            output.tappedButtonIndex.value = value
        }
    }
}

private extension MBTIViewModel {
    func validation(nickname: String?) {
        guard let nickname else { return }
        
        do {
            let _ = try checkNicknameValidity(nickname: nickname)
            output.stateMessage.value = "사용할 수 있는 닉네임이에요"
            output.nicknameValidate.value = true
        } catch let error {
            output.stateMessage.value = error.message
            output.nicknameValidate.value = false
        }
    }
    
    func checkNicknameValidity(nickname: String?) throws(NicknameInputError) {
        
        guard let nickname else { return }
        
        guard (0...10).contains(nickname.count) else {
            throw .outOfRange
        }
        
        let specialCharacters = "[@#$%]"
        if let _ = nickname.range(of: specialCharacters, options: .regularExpression) {
            throw .containsSpecialChars
        }
        
        let numbers = "[0-9]"
        if let _ = nickname.range(of: numbers, options: .regularExpression) {
            throw .containsNumbers
        }
    }
 
    func mbtiTapped() {
        // 0 1
        
        // 2 3
        // 4 5
        // 6 7
        
        //
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


// Observable 흐름을 하나로 모아서 뱉어줌
// 등록, 등록
