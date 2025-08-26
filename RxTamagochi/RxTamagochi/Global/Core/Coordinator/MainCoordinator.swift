//
//  MainCoordinator.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import UIKit
import RxSwift

final class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let nav: BaseNavigationController
    let store: TamagochiStore
    private var disposeBag = DisposeBag()
    
    init(nav: BaseNavigationController, store: TamagochiStore) {
        self.nav = nav
        self.store = store
    }
    
    func start() {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let vm = HomeViewModel(store: store)
        let vc = sb.instantiateViewController(identifier: "HomeViewController") { coder in
            HomeViewController(coder: coder, viewModel: vm)
        }
        
        vc.tabBarItem = TabBarType.tamagochi.tabBarItem
        
        vm.routes
            .bind(with: self) { owner, route in
                switch route {
                case .goSetting:
                    owner.pushSetting()
                }
            }
            .disposed(by: disposeBag)

        nav.setViewControllers([vc], animated: false)
    }
    
    func stop() {
        disposeBag = DisposeBag()
    }
}

private extension MainCoordinator {
    func pushSetting() {
        let vm = SettingViewModel(store: store)
        let vc = SettingViewController(viewModel: vm)
        nav.pushViewController(vc, animated: true)
        
        vm.routes
            .bind(with: self) { owner, route in
                switch route {
                case .goNameSetting:
                    owner.pushNameSetting()
                case .goChangeTamagochi:
                    owner.pushChangeTamagochi()
                case .reset:
                    owner.popToRootVC()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func pushNameSetting() {
        let vm = NameSettingViewModel(store: store)
        let sb = UIStoryboard(name: "NameSetting", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "NameSettingViewController") { coder in
            NameSettingViewController(coder: coder, viewModel: vm)
        }
        
        vm.routes
            .asDriver(onErrorJustReturn: .goRoot)
            .drive(with: self) { owner, route in
                switch route {
                case .goRoot:
                    owner.nav.popToRootViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        nav.pushViewController(vc, animated: true)
    }
    
    func pushChangeTamagochi() {
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
        
        nav.pushViewController(vc, animated: true)
    }
    
    func presentDetailTamagochi(type: TamagochiType) {
        let vm = SelecteDetailViewModel(store: store, selectedType: type, state: .change)
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
                    owner.nav.dismiss(animated: true) {
                        owner.nav.popToRootViewController(animated: true)
                    }
                }
                
            }
            .disposed(by: disposeBag)
        
        nav.present(vc, animated: true)
    }
    
    func popToRootVC() {
        stop()
        self.nav.popToRootViewController(animated: true)

    }
}
