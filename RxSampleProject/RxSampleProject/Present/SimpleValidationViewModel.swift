//
//  SimpleValidationViewModel.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/21/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SimpleValidationViewModel {
    struct Input {
        let usernameText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let buttonTap: ControlEvent<Void>
    }
    
    struct Output {
        let usernameValid: BehaviorRelay<Bool>
        let passwordValid: BehaviorRelay<Bool>
        let everythingValid: BehaviorRelay<Bool>
        let showAlert: BehaviorRelay<Void>
    }
    
    private let disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
        let minimalUsernameLength = 5
        let minimalPasswordLength = 5
        
        let nameValid = BehaviorRelay(value: false)
        let passwordValid = BehaviorRelay(value: false)
        let everythingValid = BehaviorRelay(value: false)
        let showAlert = BehaviorRelay(value: ())

        input.usernameText
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
            .bind(with: self) { owner, valid in
                nameValid.accept(valid)
                print("username \(valid)")
            }
            .disposed(by: disposeBag)
        
        input.passwordText
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
            .bind(with: self) { owner, valid in
                passwordValid.accept(valid)
                print("password \(valid)")
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(nameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
            .bind(with: self) { owner, value in
                everythingValid.accept(value)
                print("everything \(value)")
            }
            .disposed(by: disposeBag)
        
        input.buttonTap
            .bind { _ in
                showAlert.accept(())
            }
            .disposed(by: disposeBag)
        
        return Output(usernameValid: nameValid,
                      passwordValid: passwordValid,
                      everythingValid: everythingValid,
                      showAlert: showAlert)
    }
}

