//
//  ShoppingResultViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import UIKit
import Alamofire

final class ShoppingResultViewController: UIViewController {
    
    var viewModel: ShoppingResultViewModel
    private let shoppingResultView = ShoppingResultView()
    
    init(viewModel: ShoppingResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = shoppingResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        configureCollectionView()
        configureDelegation()
        bindData()
    }
    
    private func bindData() {
        viewModel.output.shoppingList.bind { [weak self] _ in
            guard let self else { return }
            shoppingResultView.collectionView.reloadData()
        }
        viewModel.output.recommendList.bind { [weak self] _ in
            guard let self else { return }
            shoppingResultView.horizontalCollectionView.reloadData()
        }
        viewModel.output.errorEntity.lazyBind { [weak self] value in
            guard let self else { return }
            guard let error = value else { return }
            
            self.showAlert(title: "네트워크 에러 발생", message: error.message)
        }
    }
    
    private func setupNavigation() {
        navigationItem.title = viewModel.input.query.value
    }
    
    private func configureCollectionView() {
        shoppingResultView.collectionView.dataSource = self
        shoppingResultView.collectionView.prefetchDataSource = self

        shoppingResultView.horizontalCollectionView.dataSource = self
        
        shoppingResultView.collectionView.register(ShoppingResultCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingResultCollectionViewCell.id)
        
        shoppingResultView.horizontalCollectionView.register(ShoppingHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingHorizontalCollectionViewCell.id)
    }
    
    private func configureDelegation() {
        shoppingResultView.configureDelegation(self)
    }

}

extension ShoppingResultViewController: ShoppingResultViewDelegate {
    func didSelectSort(_ sort: Sort) {
        upToScroll()
        viewModel.input.sort.value = sort
    }
    
    private func upToScroll() {
        shoppingResultView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
}

extension ShoppingResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == shoppingResultView.collectionView {
            return viewModel.output.shoppingList.value.count
        }
        
        if collectionView == shoppingResultView.horizontalCollectionView {
            return viewModel.output.recommendList.value.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == shoppingResultView.collectionView {
            guard let cell = shoppingResultView.collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingResultCollectionViewCell.id, for: indexPath) as? ShoppingResultCollectionViewCell else { return UICollectionViewCell() }

            cell.delegate = self
            cell.configure(item: viewModel.output.shoppingList.value[indexPath.item])
            
            return cell
        }
        
        if collectionView == shoppingResultView.horizontalCollectionView {
            guard let cell = shoppingResultView.horizontalCollectionView.dequeueReusableCell(withReuseIdentifier: ShoppingHorizontalCollectionViewCell.id, for: indexPath) as? ShoppingHorizontalCollectionViewCell else { return UICollectionViewCell() }

            cell.configure(item: viewModel.output.recommendList.value[indexPath.row])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ShoppingResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        viewModel.input.indexPaths.value = indexPaths
    }
}

extension ShoppingResultViewController: ShoppingResultCollectionViewCellDelegate {
    func handleLikeButtonTapped(cell: ShoppingResultCollectionViewCell) {
        if let indexPath = shoppingResultView.collectionView.indexPath(for: cell) {
            print("\(indexPath)의 하트 버튼이 눌림")
        }
    }
}




