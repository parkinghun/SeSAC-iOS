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
    private var start = 1
    private var total = 0
    private let display = 30
    private var isEnd: Bool {
        return total <= shoppingList.count
    }
    private var sort: SortType = .accuracy
    
    override func loadView() {
        self.view = shoppingResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        configureCollectionView()
        configureDelegation()
        callRequest(query: query, start: start)
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
    
    private func callRequest(query: String?, start: Int) {
        guard let query else { return }
        
        let baseURL = "https://openapi.naver.com/v1/search/shop.json"
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Naver-Client-Id", value: Bundle.getAPIKey(for: .naverClientID)),
            HTTPHeader(name: "X-Naver-Client-Secret", value: Bundle.getAPIKey(for: .naverClientSecret))
        ]
        // TODO: - encodable
        let parameters: Parameters = [
            "query": query,
            "display": display,
            "start": start,
            "sort": sort.rawValue
        ]
        
        AF.request(baseURL, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { [weak self] response in
                guard let self else { return }
                guard let myResponse = response.response else { return }
                
                switch myResponse.statusCode {
                case 200..<300:  // 성공
                    do {
                        let searchResult = try JSONDecoder().decode(SearchResult.self, from: response.data!)
                        
                        self.shoppingList.append(contentsOf: searchResult.items)
                        self.shoppingResultView.configure(searchResult)
                        
                        if start == 1 {
                            self.total = searchResult.total
                        }
                    } catch {
                        print("성공 - 디코딩 실패")
                    }
                case 400..<600:  // 실패
                    do {
                        let errorEntity = try JSONDecoder().decode(ShoppingErrorEntity.self, from: response.data!)
                        showAlert(title: "에러코드 \(errorEntity.errorCode)", message: errorEntity.errorMessage)
                        print(errorEntity)
                    } catch {
                        print("에러 - 디코딩 실패")
                    }
                default:
                    print(myResponse.statusCode)
                }
            }
    }
    
    private func resetShoppingList() {
        shoppingResultView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        start = 1
        shoppingList.removeAll()
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
        sort = .accuracy
        callRequest(query: query, start: start)
    }
    
    func tappedDateOrderButto() {
        print(#function)
        resetShoppingList()
        sort = .dateOrder
        callRequest(query: query, start: start)
    }
    
    func tappedHighPriceButto() {
        print(#function)
        resetShoppingList()
        sort = .highPrice
        callRequest(query: query, start: start)
    }
    
    func tappedLowPriceButton() {
        print(#function)
        resetShoppingList()
        sort = .lowPrice
        callRequest(query: query, start: start)
    }
}

extension ShoppingResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = shoppingResultView.collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingResultCollectionViewCell.id, for: indexPath) as? ShoppingResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.delegate = self  // 셀마다 델리겟 설정
        cell.configure(item: shoppingList[indexPath.item])
        
        return cell
    }
}

extension ShoppingResultViewController: ShoppingResultCollectionViewCellDelegate {
    func handleLikeButtonTapped(cell: ShoppingResultCollectionViewCell) {
        // 셀로 인덱스 패스 구하기
        if let indexPath = shoppingResultView.collectionView.indexPath(for: cell) {
            print("\(indexPath)의 하트 버튼이 눌림")
            // 하트 변경 로직 추가  -- 10만개만라면??
            
        }
    }
}

extension ShoppingResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("item index - ", indexPath.item)
        guard let query else { return }
        
        if indexPath.item == (shoppingList.count - 5), !isEnd {
            start += display
            callRequest(query: query, start: start)
            print("새로운 네트워크 요청")
        }
    }
}

//
//enum ShoppingAPIError: Error {
//    case authentication  // statusCode - 401
//    case server
//    case disallowed  //  403
//    case noAPI  // 404
//    
//    var description: String {
//        switch self {
//        default: return ""
//        }
//    }
//    
//}
//
//enum NetworkError {
//    case invalidURL
//    case noData
//    case decodingFailed
//}
