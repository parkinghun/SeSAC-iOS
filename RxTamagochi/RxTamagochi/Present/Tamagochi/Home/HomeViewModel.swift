//
//  HomeViewModel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ConfigureViewModelProtocol {
    enum Route {
        case goSetting
    }
    
    struct Input {
        let settingButtonTapped: ControlEvent<Void>
        let feedRiceTapped: ControlEvent<Void>
        let amountRice: ControlProperty<String>
        let feedWaterTappd: ControlEvent<Void>
        let amountWater: ControlProperty<String>
    }
    
    struct Output {
        let navigationTitle: Driver<String>
        let tamagochi: Driver<Tamagochi>
        let riceValid: Driver<Bool>
        let waterValid: Driver<Bool>
        let tamagochiTalk: Driver<String>
    }
    
    let routes = PublishRelay<Route>()

    private let store: TamagochiStore
    var disposeBag = DisposeBag()
    
    init(store: TamagochiStore) {
        self.store = store
    }
    
    func transform(input: Input) -> Output {
        input.settingButtonTapped
            .map { Route.goSetting }
            .bind(to: routes)
            .disposed(by: disposeBag)
        
        let riceValid = input.amountRice
            .map{ text in
                let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                if text.isEmpty { return true }
                return (0...99).contains(Int(text) ?? -1)
            }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        let waterValid = input.amountWater
            .map{ text in
                let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                if text.isEmpty { return true }
                return (0...99).contains(Int(text) ?? -1)
            }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        
        let feedRice = input.feedRiceTapped
            .withLatestFrom(input.amountRice)
            .withUnretained(self)
            .map { self.parseAmount($1, maxAmount: 99) }
            .map { TamagochiAction.feedRice($0) }
            
        let feedWater = input.feedWaterTappd
            .withLatestFrom(input.amountWater)
            .withUnretained(self)
            .map { self.parseAmount($1, maxAmount: 49) }
            .map { TamagochiAction.feedWater($0) }
        
        let actions = Observable.merge(feedRice, feedWater)
        let storeOut = store.transform(input: .init(action: actions))
        
        let tamagochi = storeOut.state
            .compactMap { $0 }
            .distinctUntilChanged()
        
        let tamagochiTalk = tamagochi
            .map { $0.randomMessage }
            
        
        let navigationTitle = tamagochi.map { "\($0.name)님의 다마고치"}
        
        return Output(navigationTitle: navigationTitle,
                      tamagochi: tamagochi,
                      riceValid: riceValid,
                      waterValid: waterValid,
                      tamagochiTalk: tamagochiTalk)
    }
}

private extension HomeViewModel {
    func parseAmount(_ text: String, maxAmount: Int) -> Int {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let base = trimmedText.isEmpty ? 1 : Int(trimmedText) ?? 0
        return min(maxAmount, max(0, base))
    }
}


// image -> type / level
