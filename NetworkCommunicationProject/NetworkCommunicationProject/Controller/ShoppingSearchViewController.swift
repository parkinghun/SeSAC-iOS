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
        navigationItem.title = "영캠러의 쇼핑쇼핑"
    }
    
    private func configureDelegate() {
        shoppingSearchView.searchBar.delegate = self
    }
}

extension ShoppingSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text, text.count >= 2 else {
            self.showAlert(title: "입력 글자수 부족", message: "검색어는 두글자 이상 입력해주세요.")
            return
        }
        
        let nextVC = ShoppingResultViewController()
        nextVC.query = text
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
