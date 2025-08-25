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
    enum Route {
        case goRoot
    }
    
    struct Input {
        let saveButtonTapped: ControlEvent<Void>
        let changeName: ControlProperty<String>
        
    }
    
    struct Output {
        let navigationTitle: Observable<String>
        let placeholder: Observable<String>
        let validResult: BehaviorRelay<Bool>
        let validText: BehaviorRelay<String>
        let toast: Driver<Toast>
        let currentName: Driver<String>
    }
    
    let routes = PublishRelay<Route>()
    private let store: TamagochiStore
    private let disposeBag = DisposeBag()
    
    init(store: TamagochiStore) {
        self.store = store
    }
    
    func transform(input: Input) -> Output {
        let navigationTitle = Observable.just("대장님 이름 정하기")
        let placeholder = Observable.just("이름을 입력해주세요")
        let validResult = BehaviorRelay(value: false)
        let validText = BehaviorRelay<String>(value: "동일한 이름으로 변경이 불가능합니다.")
        let toast = PublishRelay<Toast>()
        
        let currentName = store.current?.name ?? ""
        let name = Observable.just(currentName)
            .asDriver(onErrorJustReturn: "")
            
        let saveAction = input.saveButtonTapped
            .withLatestFrom(input.changeName)
            .map { TamagochiAction.changeName($0) }
            .asObservable()
        
        _ = store.transform(input: .init(action: saveAction))
        
        saveAction
            .bind(with: self) { owner, _ in
                owner.routes.accept(.goRoot)
                
                toast.accept(.init(status: .check, message: "닉네임이 성공적으로 변경되었습니다."))
            }
            .disposed(by: disposeBag)
        
        input.changeName
            .debounce(.microseconds(300), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, value in
                let result = owner.isValid(name: value)
                
                switch result {
                case .success(let text):
                    validText.accept(text)
                    validResult.accept(true)
                case .failure(let error):
                    validText.accept(error.message)
                    validResult.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(navigationTitle: navigationTitle,
                      placeholder: placeholder,
                      validResult: validResult,
                      validText: validText,
                      toast: toast.asDriver(onErrorJustReturn: .init(status: .warning, message: "")),
                      currentName: name)
    }
}

private extension NameSettingViewModel {
    func isValid(name: String) -> Result<String, NicknameValidError> {
        
        guard let tamagochi = store.current else {
            return .failure(.invalid)
        }
        
        guard tamagochi.name != name else {
            return .failure(.sameName)
        }
        guard name.count >= 2, name.count <= 6 else {
            return .failure(.count)
        }
        
        guard !name.contains(" ") else {
            return .failure(.whiteSpace)
        }
        return .success("변경 가능한 닉네임 입니다.")
    }
    
    enum NicknameValidError: Error {
        case invalid
        case sameName
        case count
        case whiteSpace
        
        var message: String {
            switch self {
            case .invalid:
                return "다마고치 없음"
            case .sameName:
                return "동일한 이름으로 변경이 불가능합니다."
            case .count:
                return "이름은 2글자 이상 6글자 이하로 작성해주세요."
            case .whiteSpace:
                return "이름에 띄어쓰기는 불가능합니다."
            }
        }
    }
    
}


