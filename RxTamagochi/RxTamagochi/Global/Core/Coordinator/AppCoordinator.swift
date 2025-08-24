//
//  AppCoordinator.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import UIKit
import RxSwift

final class AppCoordinator: Coordinator {
    enum Flow {
        case start
        case main
    }
    
    private let window: UIWindow
    private let nav = BaseViewController()
    private let store = TamagochiStore()
    private var current: Coordinator?
    private let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        let output = store.transform(input: .init(action: .empty()))
        output.state
            .map { $0 == nil ? Flow.start : Flow.main }
            .distinctUntilChanged()
            .drive(with: self) { owner, flow in
                owner.switchFlow(flow)
            }
            .disposed(by: disposeBag)
    }
    
    func stop() {
        
    }
}

private extension AppCoordinator {
    func switchFlow(_ flow: Flow) {
        current?.stop()
        
        switch flow {
        case .start:
            print("첫 화면 전환")
//            let coordinator = StartCoordinator(nav: nav, store: store)
        case .main:
            let coordinator = MainCoordinator(nav: nav, store: store)
            current = coordinator
            coordinator.start()
        }
    }
}


