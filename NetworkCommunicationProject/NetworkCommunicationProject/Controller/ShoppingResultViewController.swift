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
    private var page = 1
    private var total = 0
    private let display = 30
    private var isEnd: Bool {
        return total > page * display ? false : true
    }
    
    override func loadView() {
        self.view = shoppingResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        configureCollectionView()
        configureDelegation()
        callRequest(query: query, page: page)
    }
    
    private func setupNavigation() {
        navigationItem.title = query
    }
    
    private func configureCollectionView() {
        shoppingResultView.collectionView.delegate = self
        shoppingResultView.collectionView.dataSource = self
        
        shoppingResultView.collectionView.register(ShoppingResultCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingResultCollectionViewCell.id)
    }
    
    private func configureDelegation() {
        shoppingResultView.configureDelegation(self)
    }
    
    private func callRequest(query: String?, page: Int, sort: SortType = .accuracy) {
        guard let query else { return }
        
        let baseURL = "https://openapi.naver.com/v1/search/shop.json"
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Naver-Client-Id", value: Bundle.getAPIKey(for: .naverClientID)),
            HTTPHeader(name: "X-Naver-Client-Secret", value: Bundle.getAPIKey(for: .naverClientSecret))
        ]
        
        let parameters: Parameters = [
            "query": query,
            "display": display,
            "start": page,
            "sort": sort.rawValue
        ]
        
        AF.request(baseURL, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchResult.self) { [weak self] response in
                guard let self else{ return }
                
                switch response.result {
                case let .success(value):
                    self.shoppingList.append(contentsOf: value.items)
                    self.shoppingResultView.configure(value)

                    if page == 1 {
                        total = value.total
                        shoppingResultView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    }
                    
                case let .failure(error):
                    print("Failure", error)
                }
            }
    }
    
    private func resetShoppingList() {
        shoppingList.removeAll()
        page = 1
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

extension ShoppingResultViewController: ShoppingResultViewDelegate {
    func tappedAccuracyButton() {
        print(#function)
        resetShoppingList()
        callRequest(query: query, page: page, sort: .accuracy)
    }
    
    func tappedDateOrderButto() {
        print(#function)
        resetShoppingList()
        callRequest(query: query, page: page, sort: .dateOrder)
    }
    
    func tappedHighPriceButto() {
        print(#function)
        resetShoppingList()
        callRequest(query: query, page: page, sort: .highPrice)
    }
    
    func tappedLowPriceButton() {
        print(#function)
        resetShoppingList()
        callRequest(query: query, page: page, sort: .lowPrice)
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.item)
        guard let query else { return }
        
        if indexPath.item == (shoppingList.count - 5), !isEnd {
            page += 1
            callRequest(query: query, page: page)
        }
    }
}
