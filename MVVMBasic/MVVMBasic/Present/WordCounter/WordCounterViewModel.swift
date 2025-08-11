//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/8/25.
//

import Foundation

final class WordCounterViewModel {
    
    var inputText: Observable<String?> = Observable("")
    var outputText = Observable("")
    
    init() {
        inputText.bind { [weak self] text in
            guard let self, let text else { return }
            outputText.value = updateCharacterCount(text: text)
        }
    }
}

private extension WordCounterViewModel {
    func updateCharacterCount(text: String) -> String {
        return "현재까지 \(text.count)글자 작성중"
    }
}
