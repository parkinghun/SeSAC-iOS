//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/8/25.
//

import Foundation

final class CurrencyViewModel {
    var inputField: Observable<String?> = Observable("")
    var outputText = Observable("")
    
    init() {
        inputField.lazyBind { [weak self] inputText in
            guard let self else { return }
            outputText.value = calculateCurrency(text: inputText)
        }
    }
}

private extension CurrencyViewModel {
    func calculateCurrency(text: String?) -> String {
        guard let text,
              let amount = Double(text) else {
            return "올바른 금액을 입력해주세요"
        }
        
        let exchangeRate = 1391.3
        let convertedAmount = amount / exchangeRate
        return String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
