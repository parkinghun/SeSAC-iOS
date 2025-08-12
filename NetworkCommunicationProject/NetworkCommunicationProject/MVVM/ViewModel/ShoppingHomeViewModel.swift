//
//  ShoppingHomeViewModel.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 8/12/25.
//

import Foundation

final class ShoppingHomeViewModel {
    var inputGoButtonTrigger = Observable(())
    private(set) var outputPushVCTrigger = Observable(())
    
    var title: String {
        return "쇼핑"
    }
    
    init() {
        inputGoButtonTrigger.lazyBind { [weak self] _ in
            guard let self else { return }
            outputPushVCTrigger.value = ()
        }
    }
}
