//
//  SelecteDetailViewModel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SelecteDetailViewModel: ConfigureViewModelProtocol {
    enum State {
        case start
        case change
    }
    
    enum Route {
        case cancel
        case confirm
    }
    
    struct Input {
        let cancelButtonTapped: ControlEvent<Void>
        let startButtonTapped: ControlEvent<Void>
        let tapEvent: ControlEvent<UITapGestureRecognizer>
    }
    
    struct Output {
        let toast: PublishRelay<Toast>
        let navigationTitle: PublishRelay<String>
    }
    
    let routes = PublishRelay<Route>()
    private let selectedType: TamagochiType
    private let store: TamagochiStore
    private let state: State
    var disposeBag = DisposeBag()
    
    init(store: TamagochiStore, selectedType: TamagochiType, state: State) {
        self.store = store
        self.selectedType = selectedType
        self.state = state
    }
    
    func transform(input: Input) -> Output {
        
        let toast = PublishRelay<Toast>()
        let navigationTitle = PublishRelay<String>()
        switch state {
        case .start:
            navigationTitle.accept("다마고치 선택하기")
        case .change:
            navigationTitle.accept("다마고치 변경하기")
        }
        
        let cancelBtTapped = input.cancelButtonTapped.asObservable()
        let tapEvent = input.tapEvent.map { _ in }.asObservable()
        
        Observable.merge(cancelBtTapped, tapEvent)
            .bind(with: self) { owner, _ in
                owner.routes.accept(.cancel)
            }
            .disposed(by: disposeBag)
        
        input.startButtonTapped
            .bind(with: self) { owner, _ in
                
                owner.routes.accept(.confirm)

                switch owner.state {
                case .start:
                    _ = owner.store.transform(input: .init(action: .just(.set(.init(type: owner.selectedType)))))
                    toast.accept(.init(status: .check, message: "다마고치를 성공적으로 생성했습니다."))
                case .change:
                    _ = owner.store.transform(input: .init(action: .just(.changeTamagochi(owner.selectedType))))
                    
                    toast.accept(.init(status: .check, message: "다마고치를 성공적으로 변경했습니다."))
                }
            }
            .disposed(by: disposeBag)
        
        
        return Output(toast: toast, navigationTitle: navigationTitle)
    }
}
