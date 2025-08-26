//
//  NetworkManager.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/26/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                
                guard Connectivity.isConnectedToInternet else {
                    print("네트워크 연결X")
                    completion(.failure(.unrechable))
                    return
                }
                
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                    
                case .failure(let error):
                    print("네트워크 에러 발생", error)
                    completion(.failure(.invalid))
                }
            }
    }
}

enum NetworkError: Error {
    case invalid
    case unrechable
    
    var message: String {
        switch self {
        case .invalid:
            return "알 수 없는 에러"
        case .unrechable:
            return "데이터 통신 상태를 확인해주세요"
        }
    }
}
