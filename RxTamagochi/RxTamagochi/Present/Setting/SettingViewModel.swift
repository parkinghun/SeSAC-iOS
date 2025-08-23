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
        // alert ok 버튼 클릭
    }
    
    struct Output {
        let cellData: Observable<[Setting]>
        
        let nameSetting: PublishRelay<Void>  // Tamagochi 넘겨줘야함
        let changeTamagochi: PublishRelay<Void>  // ??
        let resetData: PublishRelay<AlertStyle>  // 알럿 타이틀 메시지(웅/아냐!)
    }
    
//    private let setting = Setting.allCases
    private let disposeBag = DisposeBag()
    init() { }
    
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
                    resetData.accept(.init(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가용?", ok: "웅", cancel: "아냐!", handler: {
                        owner.resetData()
                    }))
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
    func resetData() {
        TamagochiManager.shared.delete()
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
        switch self {
        case .name: return TamagochiManager.shared.tamagochi.name
        default: return ""
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
