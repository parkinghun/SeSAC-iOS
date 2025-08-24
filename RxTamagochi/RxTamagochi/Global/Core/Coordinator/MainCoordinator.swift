//
//  MainCoordinator.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import Foundation

final class MainCoordinator: Coordinator {
    let nav: BaseViewController
    let store: TamagochiStore
    
    init(nav: BaseViewController, store: TamagochiStore) {
        self.nav = nav
        self.store = store
    }
    
    func start() {
        let vm = SettingViewModel(store: store)
        let vc = SettingViewController(viewModel: vm)
    }
    
    func stop() {
        
    }
}
