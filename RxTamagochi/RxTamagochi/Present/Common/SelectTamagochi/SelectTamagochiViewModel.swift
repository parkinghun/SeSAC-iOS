//
//  SelectTamagochiViewModel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SelectTamagochiViewModel: ConfigureViewModelProtocol {
    
    enum Route {
        case presentDetail(TamagochiType)
    }
    
    struct Input {
        let modelSelected: ControlEvent<TamagochiType>
    }
    
    struct Output {
        let data: BehaviorRelay<[TamagochiType]>
    }
    
    let routes = PublishRelay<Route>()
    
    private let store: TamagochiStore
    var disposeBag = DisposeBag()
        
    init(store: TamagochiStore) {
        self.store = store
    }
    
    func transform(input: Input) -> Output {
        var tamagochiType = TamagochiType.allCases
        tamagochiType.append(contentsOf: Array(repeating: TamagochiType.prepare, count: 23))

        let data = BehaviorRelay(value: tamagochiType)
        
        input.modelSelected
            .compactMap { type -> TamagochiType? in
                switch type {
                case .tingling, .smile, .twinkle: return type
                default: return nil
                }
            }
            .map { Route.presentDetail($0) }
            .bind(to: routes)
            .disposed(by: disposeBag)
        
        return Output(data: data)
    }
}
