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
        case tab
    }
    
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let nav = BaseNavigationController()
    private let store = TamagochiStore()
    private var disposeBag = DisposeBag()

    private var current: Coordinator?

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = nav
        window.makeKeyAndVisible()
                
        let output = store.transform(input: .init(action: .empty()))
        output.state
            .map { $0 == nil ? Flow.start : Flow.tab }
            .distinctUntilChanged()
            .drive(with: self) { owner, flow in
                owner.switchFlow(flow)
            }
            .disposed(by: disposeBag)
    }
    
    func stop() {
        disposeBag = DisposeBag()
    }
}

private extension AppCoordinator {
    func switchFlow(_ flow: Flow) {
        current?.stop()
        
        switch flow {
        case .start:
            let coordinator = StartCoordinator(nav: nav, store: store)
            
            window.rootViewController = nav
            nav.setViewControllers([], animated: false)
            current = coordinator
            coordinator.start()
        case .tab:
            let coordinator = TabBarCoordinator(store: store)
            window.rootViewController = coordinator.tabBarController
            current = coordinator
            nav.setViewControllers([], animated: false)
            coordinator.start()
        }
    }
}


