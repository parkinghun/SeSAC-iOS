//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/8/25.
//

import Foundation

final class WordCounterViewModel {
    var inputText: String? = "" {
        didSet {
            print(#function)
            updateCharacterCount()
        }
    }
    
    var outputText: String = "" {
        didSet {
            closure?()
        }
    }
    
    var closure: (() -> Void)?
    
    private func updateCharacterCount() {
        guard let inputText else {
            outputText = ""
            return
        }
        outputText = "현재까지 \(inputText.count)글자 작성중"
    }
    
    
}
