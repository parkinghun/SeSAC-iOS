//
//  NetworkManager.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/29/25.
//

import Foundation
import Alamofire

//protocol APIRequst {
//    var baseURL: String { get }
//    var paramters: Parameters { get }
//    var headers: HTTPHeaders? { get }
//}
//
//final class NetworkManager {
//    
//    static let shared = NetworkManager()
//    
//    private init() { }
//    
//    func fetchData<T: Decodable>(kind: APIType) {
//        let api = kind.apiInfo
//        
//        AF.request(api.baseURL, method: .get, parameters: api.paramters, headers: api.headers)
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: ) { response in
//                <#code#>
//            }
//    }
//}
//
//extension NetworkManager {
//    struct APIInfo {
//        let baseURL: String
//        let headers: HTTPHeaders? = nil
//        let paramters: Parameters
//    }
//    
//    enum APIType {
//        case lotto(round: Int)
//        case movie(key: String, date: String)
//        case naverShopping
//        
//        var apiInfo: APIInfo {
//            switch self {
//            case let .lotto(round):
//                return APIInfo(
//                    baseURL: " https://www.dhlottery.co.kr/common.do",
//                    paramters: ["method": "getLottoNumber",
//                                "drwNo": round])
//            case let .movie(key, date):
//                return APIInfo(
//                    baseURL: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
//                    paramters: ["key": key,
//                                "targetDt": date])
//            case .naverShopping:
//                return APIInfo(baseURL: "https://openapi.naver.com/v1/search/shop.json",
//                               headers: [
//                                HTTPHeader(name: "X-Naver-Client-Id", value: Bundle.getAPIKey(for: .naverClientID)),
//                                HTTPHeader(name: "X-Naver-Client-Secret", value: Bundle.getAPIKey(for: .naverClientSecret))
//                            ],
//                               paramters: [
//                                "query": query,
//                                "display": display,
//                                "start": page,
//                                "sort": sort.rawValue
//                            ])
//            }
//        }
//    }
//}
