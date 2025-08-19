//
//  ShoppingRouter.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 8/13/25.
//

import Foundation
import Alamofire

enum Sort: String, Encodable, CaseIterable {
    case sim, date, dsc, asc
}

enum ShoppingRouter { 
    case search(parameters: Parameters)
    
    private var baseURL: String {
        return "https://openapi.naver.com/"
    }
    
    var enidPoint: URL {
        switch self {
        case .search(_):
            return URL(string: baseURL + "v1/search/shop.json")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .search(let parameters):
            return parameters
        }
    }
    
    var headers: HTTPHeaders {
        let headers = [
            HTTPHeader(name: "X-Naver-Client-Id", value: Bundle.getAPIKey(for: .naverClientID)),
            HTTPHeader(name: "X-Naver-Client-Secret", value: Bundle.getAPIKey(for: .naverClientSecret))
        ]
        
        return HTTPHeaders(headers)
    }
    
    struct Parameters: Encodable {
        var query: String
        var display: Int
        var start: Int
        var sort: Sort
        
    }
}
