//
//  ShoppingViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import UIKit

final class ShoppingHomeViewController: UIViewController {
    
    private let shoppingHomeView = ShoppingHomeView()
    
    override func loadView() {
        self.view = shoppingHomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegation()
        setupNavigation()
    }
    
    private func configureDelegation() {
        shoppingHomeView.configureDelegation(self)
    }
    
    private func setupNavigation() {
        navigationController?.title = "쇼핑"
    }
}

extension ShoppingHomeViewController: ShoppingHomeViewDelegate {
    func tappedGoButton() {
        print(#function)
        navigationController?.pushViewController(ShoppingSearchViewController(), animated: true)
    }
}


