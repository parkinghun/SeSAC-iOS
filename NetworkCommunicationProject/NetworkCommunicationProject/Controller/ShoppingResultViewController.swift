//
//  ShoppingResultViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import UIKit
import Alamofire

final class ShoppingResultViewController: UIViewController {
    
    var query: String?
    
    private let shoppingResultView = ShoppingResultView()
    private var shoppingList: [Product] = [] {
        didSet {
            shoppingResultView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = shoppingResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        configureCollectionView()
        callRequest(query: query)
    }
    
    private func setupNavigation() {
        navigationItem.title = query
    }
    
    private func configureCollectionView() {
        shoppingResultView.collectionView.delegate = self
        shoppingResultView.collectionView.dataSource = self
        
        shoppingResultView.collectionView.register(ShoppingResultCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingResultCollectionViewCell.id)
    }
    
    private func callRequest(query: String?, display: Int = 100, sort: SortType = .accuracy) {
        guard let query else { return }
        
        let baseURL = "https://openapi.naver.com/v1/search/shop.json"
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Naver-Client-Id", value: Bundle.getAPIKey(for: .naverClientID)),
            HTTPHeader(name: "X-Naver-Client-Secret", value: Bundle.getAPIKey(for: .naverClientSecret))
        ]
        
        let parameters: Parameters = [
            "query": query,
            "display": display,
            "sort": sort.rawValue
        ]
        
        AF.request(baseURL, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchResult.self) { [weak self] response in
                guard let self else{ return }
                
                switch response.result {
                case let .success(value):
                    dump(value.items[0])
                    self.shoppingList = value.items
                    self.shoppingResultView.configure(value)
                case let .failure(error):
                    print("Failure", error)
                }
            }
    }
}

extension ShoppingResultViewController {
    enum SortType: String {
        case accuracy = "sim"
        case dateOrder = "date"
        case highPrice = "dsc"
        case lowPrice = "asc"
    }
}

extension ShoppingResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = shoppingResultView.collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingResultCollectionViewCell.id, for: indexPath) as? ShoppingResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(item: shoppingList[indexPath.item])
        
        return cell
    }
}

extension ShoppingResultViewController: UICollectionViewDelegate {
    
}
