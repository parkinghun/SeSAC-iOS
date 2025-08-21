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
        let usernameValidText: Observable<String>
        let passwordValidText: Observable<String>
    }
    
    private let disposeBag = DisposeBag()
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    init() { }
    
    func transform(input: Input) -> Output {

        let nameValid = BehaviorRelay(value: false)
        let passwordValid = BehaviorRelay(value: false)
        let everythingValid = BehaviorRelay(value: false)
        let showAlert = BehaviorRelay(value: ())
        let nameText = Observable.just("Username has to be at least \(minimalUsernameLength) characters")
        let passwordText = Observable.just("Password has to be at least \(minimalPasswordLength) characters")
        
        input.usernameText
            .withUnretained(self)
            .map { $1.count >= self.minimalUsernameLength }
            .share(replay: 1)
            .bind(with: self) { owner, valid in
                nameValid.accept(valid)
                print("username \(valid)")
            }
            .disposed(by: disposeBag)
        
        input.passwordText
            .withUnretained(self)
            .map { $1.count >= self.minimalPasswordLength }
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
                      showAlert: showAlert,
                      usernameValidText: nameText,
                      passwordValidText: passwordText)
    }
}

