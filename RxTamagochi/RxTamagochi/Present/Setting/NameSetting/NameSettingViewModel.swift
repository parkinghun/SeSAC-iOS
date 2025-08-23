//
//  SettingViewModel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NameSettingViewModel {
    struct Input {
        let saveButtonTapped: ControlEvent<Void>
        let changeName: ControlProperty<String>
        
    }
    
    struct Output {
        let navigationTitle: Observable<String>
        let placeholder: Observable<String>
        let validText: PublishRelay<String>
    }
    
    private let disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
        let navigationTitle = Observable.just("대장님 이름 정하기")
        let placeholder = Observable.just("이름을 입력해주세요")
        let validText = PublishRelay<String>()
        
        input.changeName
            .debounce(.microseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, value in
                let text = owner.isValid(name: value)
                validText.accept(text)
            }
            .disposed(by: disposeBag)
        
        input.saveButtonTapped
            .withLatestFrom(input.changeName)
            .bind(with: self) { owner, value in
                // 알럿 띄우기
//                owner.isValid(name: value)
            }
            .disposed(by: disposeBag)
        
        return Output(navigationTitle: navigationTitle, placeholder: placeholder, validText: validText)
    }
}

private extension NameSettingViewModel {
    func isValid(name: String) -> String{
        guard TamagochiManager.shared.tamagochi.name != name else {
            return "동일한 이름으로 변경이 불가능합니다."
        }
        guard name.count >= 2, name.count <= 6 else {
            return "이름은 2글자 이상 6글자 이하로 작성해주세요."
        }

        guard !name.contains(" ") else {
            return "이름에 띄어쓰기는 불가능합니다."
        }
        return "변경 가능한 닉네임 입니다."
    }
}
