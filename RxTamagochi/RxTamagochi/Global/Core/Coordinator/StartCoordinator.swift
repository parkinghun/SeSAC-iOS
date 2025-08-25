//
//  StartCoordinator.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import Foundation
import RxSwift

final class StartCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    let nav: BaseNavigationController
    let store: TamagochiStore
    private var disposeBag = DisposeBag()
    
    init(nav: BaseNavigationController, store: TamagochiStore) {
        self.nav = nav
        self.store = store
    }
    
    func start() {
        let vm = SelectTamagochiViewModel(store: store)
        let vc = SelectTamagochiViewController(viewModel: vm)
        
        vm.routes
            .asDriver(onErrorJustReturn: .presentDetail(.prepare))
            .drive(with: self) { owner, route in
                switch route {
                case .presentDetail(let type):
                    owner.presentDetailTamagochi(type: type)
                }
            }
            .disposed(by: disposeBag)
        
        nav.setViewControllers([vc], animated: false)
    }
    
    func presentDetailTamagochi(type: TamagochiType) {
        let vm = SelecteDetailViewModel(store: store, selectedType: type, state: .start)
        let vc = SelecteDetailViewController(viewModel: vm)
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.configure(item: type)
        
        vm.routes
            .asDriver(onErrorJustReturn: .cancel)
            .drive(with: self) { owner, route in
                switch route {
                case .cancel:
                    owner.nav.dismiss(animated: true)
                case .confirm:
                    owner.nav.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        nav.present(vc, animated: true)
    }
    
    func stop() {
        disposeBag = DisposeBag()
    }
}
