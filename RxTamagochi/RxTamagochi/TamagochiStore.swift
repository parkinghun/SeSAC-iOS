//
//  TamagochiStore.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa

enum TamagochiAction {
    case set(Tamagochi)
    case feedRice(Int = 1)
    case feedWater(Int = 1)
    case changeTamagochi(TamagochiType = .smile)
    case changeName(String = "대장")
    case reset
}

final class TamagochiStore {
    struct Input { let action: Observable<TamagochiAction> }
    struct Output { let state: Driver<Tamagochi?> }
    
    var current: Tamagochi? { stateRelay.value }
    private let key = "tamagochi"
    private let stateRelay: BehaviorRelay<Tamagochi?>
    private let disposeBag = DisposeBag()
    private let userDefaults = UserDefaults.standard
    
    init() {
        if let data = userDefaults.data(forKey: key),
           let tamagochi = try? JSONDecoder().decode(Tamagochi.self, from: data) {
            stateRelay = BehaviorRelay(value: tamagochi)
        } else {
            stateRelay = BehaviorRelay(value: nil)
        }
        
        stateRelay
            .distinctUntilChanged()
            .bind(with: self) { owner, tamagochi in
                owner.persist(tamagochi)
            }
            .disposed(by: disposeBag)
    }
    
    func transform(input: Input) -> Output {
        input.action
            .bind(with: self) { owner, action in
                owner.doAction(action)
            }
            .disposed(by: disposeBag)
        
        let state = stateRelay.asDriver(onErrorJustReturn: nil)
        
        return Output(state: state)
    }
}

private extension TamagochiStore {
    func doAction(_ action: TamagochiAction) {
        switch action {
        case .set(var tamagochi):
            tamagochi.level = calculateLevel(rice: tamagochi.rice, water: tamagochi.water)
            stateRelay.accept(tamagochi)
        case .feedRice(let amount):
            guard var tamagochi = stateRelay.value else { return }
            tamagochi.rice += amount
            tamagochi.level = calculateLevel(rice: tamagochi.rice, water: tamagochi.water)
            stateRelay.accept(tamagochi)
            
        case .feedWater(let amount):
            guard var tamagochi = stateRelay.value else { return }
            tamagochi.water += amount
            tamagochi.level = calculateLevel(rice: tamagochi.rice, water: tamagochi.water)
            stateRelay.accept(tamagochi)
            
        case .changeTamagochi(let type):
            guard var tamagochi = stateRelay.value else { return }
            tamagochi.type = type
            stateRelay.accept(tamagochi)
            
        case .changeName(let name):
            guard var tamagochi = stateRelay.value else { return }
            tamagochi.name = name
            stateRelay.accept(tamagochi)
        case .reset:
            stateRelay.accept(nil)
        }
    }
    
    func persist(_ tamagochi: Tamagochi?) {
        if let tamagochi,
           let data = try?JSONEncoder().encode(tamagochi) {
            userDefaults.set(data, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
    }
    
    func calculateLevel(rice: Int, water: Int) -> Int {
        let total = Double(rice) / 5 + Double(water) / 2
        return min(10, max(1, Int(total / 10.0)))
    }
}
