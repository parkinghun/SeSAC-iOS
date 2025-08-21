//
//  NumbersViewModel.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/21/25.
//

import UIKit
import RxSwift
import RxCocoa

final class NumbersViewModel {
    struct Input {
        let number1: ControlProperty<String>
        let number2: ControlProperty<String>
        let number3: ControlProperty<String>
    }
    
    struct Output {
        let addText: BehaviorRelay<String>
    }
    
    private let disposeBag = DisposeBag()
    
    init() { }
    
    func transorm(input: Input) -> Output {
        
        // Output의 addText를 바로 사용하지 않고, 얘를 사용하는 이유
        // output에 접근할 수 가 없음(초기화 전)
        let resultText = BehaviorRelay(value: "")
        
        Observable.combineLatest(input.number1, input.number2, input.number3) { value1, value2, value3 -> Int in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map { $0.description }
        .bind(with: self) { owner, value in
            resultText.accept(value)
        }
        .disposed(by: disposeBag)
        
        return Output(addText: resultText)
    }
}

