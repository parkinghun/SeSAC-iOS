//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/8/25.
//

import Foundation

final class CurrencyViewModel {
    var inputField: String? = "" {
        didSet {
            print(#function)
            calculateCurrency()
        }
    }
    
    var outputText = "" {
        didSet {
            print(#function)
            closureText?()
        }
    }
    
    var closureText: (() -> Void)?
    
    private func calculateCurrency() {
        guard let amountText = inputField,
              let amount = Double(amountText) else {
            outputText = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1391.3
        let convertedAmount = amount / exchangeRate
        outputText = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
