//
//  ShoppingHomeViewModel.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 8/12/25.
//

import Foundation

final class ShoppingHomeViewModel {
    
    struct Input {
        var goButtonTrigger = Observable(())
    }
    struct Output {
        private(set) var pushVCTrigger = Observable(())
    }
    
    var input: Input
    var output: Output
    var title: String {
        return "쇼핑"
    }
    
    init() {
        input = Input()
        output = Output()
        
        input.goButtonTrigger.lazyBind { [weak self] _ in
            guard let self else { return }
            output.pushVCTrigger.value = ()
        }
    }
}
