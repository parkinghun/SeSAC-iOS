//
//  ShoppingSearchViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import UIKit

final class ShoppingSearchViewController: UIViewController {
    
    private let shoppingSearchView = ShoppingSearchView()
    
    override func loadView() {
        self.view = shoppingSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        configureDelegate()
    }
    
    private func setupNavigation() {
        navigationController?.title = "영캠러의 쇼핑쇼핑"
    }
    
    private func configureDelegate() {
        shoppingSearchView.searchBar.delegate = self
    }
}

extension ShoppingSearchViewController: UISearchBarDelegate {
    
}
