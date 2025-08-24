//
//  SettingViewModel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: ConfigureViewModelProtocol {
    
    struct Input {
        let selectedSetting: ControlEvent<Setting>
    }
    
    struct Output {
        let cellData: Observable<[Setting]>
        let nameSetting: PublishRelay<Void>
        let changeTamagochi: PublishRelay<Void>
        let resetData: PublishRelay<AlertStyle>
//        let tamagochiState: Observable<TamagochiState>
        // 삭제시 뷰 변경하기
    }
    
    private let store: TamagochiStore
    private let disposeBag = DisposeBag()
    init(store: TamagochiStore) {
        self.store = store
    }
    
    func transform(input: Input) -> Output {
        let setting = Observable.just(Setting.allCases)
        let nameSetting = PublishRelay<Void>()
        let changeTamagochi = PublishRelay<Void>()
        let resetData = PublishRelay<AlertStyle>()
        
        input.selectedSetting
            .bind(with: self) { owner, setting in
                switch setting {
                case .name:
                    nameSetting.accept(())
                case .change:
                    changeTamagochi.accept(())
                case .reset:
                    resetData.accept(.init(
                        title: "데이터 초기화",
                        message: "정말 다시 처음부터 시작하실 건가용?",
                        ok: "웅",
                        cancel: "아냐!",
                        handler: {
                            owner.sendReset()
                        }
                    ))
                }
            }
            .disposed(by: disposeBag)
        
        
        return Output(cellData: setting,
                      nameSetting: nameSetting,
                      changeTamagochi: changeTamagochi,
                      resetData: resetData)
    }
}

private extension SettingViewModel {
    func sendReset() {
        _ = store.transform(input: .init(action: .just(.reset)))
    }
}

enum Setting: CaseIterable {
    case name
    case change
    case reset
    
    var title: String {
        switch self {
        case .name: return "내 이름 설정하기"
        case .change: return "다마고치 변경하기"
        case .reset: return "데이터 초기화"
        }
    }
    
    var image: String {
        switch self {
        case .name: return "pencil"
        case .change: return "moon.fill"
        case .reset: return "arrow.clockwise"
        }
    }
    
    var rightTitle: String {
        let state = TamagochiManager.shared.state
        
        if case .active(let tamagochi) = state, self == .name {
            return tamagochi.name
        } else {
            return ""
        }
    }
}

struct AlertStyle {
    var title: String
    var message: String
    var ok: String
    var cancel: String
    var handler: (() -> Void)?
}
