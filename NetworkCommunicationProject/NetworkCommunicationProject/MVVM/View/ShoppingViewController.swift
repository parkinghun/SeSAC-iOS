//
//  ShoppingViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import UIKit

final class ShoppingHomeViewController: UIViewController {
    
    private let shoppingHomeView = ShoppingHomeView()
    private let viewModel = ShoppingHomeViewModel()
    
    override func loadView() {
        self.view = shoppingHomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegation()
        setupNavigation()
        bindData()
    }
}

private extension ShoppingHomeViewController {
    func configureDelegation() {
        shoppingHomeView.configureDelegation(self)
    }
    
    func setupNavigation() {
        navigationItem.title = viewModel.title
    }
    
    func bindData() {
        viewModel.outputPushVCTrigger.lazyBind { [weak self] _ in
            guard let self else { return }
            navigationController?.pushViewController(ShoppingSearchViewController(), animated: true)
        }
    }
}

extension ShoppingHomeViewController: ShoppingHomeViewDelegate {
    func tappedGoButton() {
        print(#function)
        viewModel.inputGoButtonTrigger.value = ()
    }
}


