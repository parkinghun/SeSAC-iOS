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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        callRequest(query: query)
    }
    
    func setupNavigation() {
        navigationItem.title = query
    }
    
    func callRequest(query: String?, display: Int = 100) {
        guard let query else { return }
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=\(display)"
        
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Naver-Client-Id", value: Bundle.getAPIKey(for: .naverClientID)),
            HTTPHeader(name: "X-Naver-Client-Secret", value: Bundle.getAPIKey(for: .naverClientSecret))
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShoppingResult.self) { response in
                switch response.result {
                case let .success(value):
                    dump(value.items[0])
                case let .failure(error):
                    print("Failure", error)
                }
            }
    }
}
