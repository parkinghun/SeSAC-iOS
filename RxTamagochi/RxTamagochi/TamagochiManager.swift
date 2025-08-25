//
//  TamagochiManager.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa
//
//enum TamagochiState: UserDefaultsStorable, Codable {
//    case active(Tamagochi)
//    case inactive
//    
//    static let key = "Tamagochi"
//}
//
//extension TamagochiState {
//    var tamagochi: Tamagochi? {
//        switch self {
//        case .active(let tamagochi):
//            return tamagochi
//        case .inactive:
//            return nil
//        }
//    }
//    
//    var isActive: Bool {
//        switch self {
//        case .active: return true
//        case .inactive: return false
//        }
//    }
//}
//
//final class TamagochiManager {
//    
//    static let shared = TamagochiManager()
//
//    private init() { }
//    
//    let stateRelay = BehaviorRelay<TamagochiState>(value: UserDefaultsManager.shared.loadData(TamagochiState.self) ?? .inactive)
//    
//    var state: TamagochiState {
//        get { stateRelay.value }
//        set {
//            stateRelay.accept(newValue)
//            UserDefaultsManager.shared.saveData(newValue)
//        }
//    }
//    
//    func delete() {
//        state = .inactive
//        UserDefaultsManager.shared.deleteData(TamagochiState.self)
//    }
//}
