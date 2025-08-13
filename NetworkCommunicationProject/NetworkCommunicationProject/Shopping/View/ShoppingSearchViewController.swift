//
//  ShoppingSearchViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import UIKit

final class ShoppingSearchViewController: UIViewController {
    
    private let shoppingSearchView = ShoppingSearchView()
    
    let viewModel = ShoppingSearchViewModel()
    
    override func loadView() {
        self.view = shoppingSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setupNavigation()
        configureDelegate()
    }
}

private extension ShoppingSearchViewController {
    func bindData() {
        viewModel.outputQuery.lazyBind { [weak self] value in
            guard let self else { return }
            guard let value else {
                showAlert(title: viewModel.alertTitle, message: viewModel.alertMessage)
                return
            }
            
            let nextVC = ShoppingResultViewController(viewModel: .init(query: value))
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func setupNavigation() {
        navigationItem.title = viewModel.title
    }
    
    func configureDelegate() {
        shoppingSearchView.searchBar.delegate = self
    }
}

extension ShoppingSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchText.value = searchBar.text
    }
}
