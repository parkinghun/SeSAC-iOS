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
    enum Route {
        case goNameSetting
        case goChangeTamagochi
        case reset
    }
    struct Input {
        let selectedSetting: ControlEvent<SettingRow>
    }
    
    struct Output {
        let cellData: Driver<[SettingRow]>
        let deleteAlert: PublishRelay<AlertStyle>
    }
    
    let routes = PublishRelay<Route>()
    private let store: TamagochiStore
    var disposeBag = DisposeBag()
    init(store: TamagochiStore) {
        self.store = store
    }
    
    func transform(input: Input) -> Output {

        let state = store.transform(input: .init(action: .empty())).state
        
        let rows = state
            .compactMap { $0 }
            .map { tamagochi in
                Setting.allCases.map { kind in
                    let title = (kind == .name) ? tamagochi.name : ""
                    return SettingRow(kind: kind, rightTitle: title)
                }
            }
        
        let deleteAlert = PublishRelay<AlertStyle>()
        
        input.selectedSetting
            .bind(with: self) { owner, row in
                switch row.kind {
                case .name:
                    owner.routes.accept(.goNameSetting)
                case .change:
                    owner.routes.accept(.goChangeTamagochi)
                case .reset:
                    deleteAlert.accept(.init(
                        title: "데이터 초기화",
                        message: "정말 다시 처음부터 시작하실 건가용?",
                        ok: "웅",
                        cancel: "아냐!",
                        handler: {
                            owner.routes.accept(.reset)
                            owner.sendReset()
                        }
                    ))
                }
            }
            .disposed(by: disposeBag)
        
        
        return Output(cellData: rows,
                      deleteAlert: deleteAlert)
    }
}

private extension SettingViewModel {
    func sendReset() {
        _ = store.transform(input: .init(action: .just(.reset)))
    }
}

struct SettingRow {
    let kind: Setting
    let rightTitle: String
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
}

struct AlertStyle {
    var title: String
    var message: String
    var ok: String
    var cancel: String
    var handler: (() -> Void)?
}
