//
//  Observable.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/11/25.
//

import Foundation

final class Observable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)  // 바뀐 T 값을 아규먼트로 전달
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)  // vlaue의 초기값으로 먼저 실행시키기 위함
        self.closure = closure
    }
}
