//
//  NetworkManager.swift
//  LocationProject
//
//  Created by 박성훈 on 9/9/25.
//

import Foundation
import Alamofire


final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func request<T: Decodable>(api: NetworkRouter, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let endPoint = api.endPoint else {
            completion(.failure(.invalid))
            return
        }
        
        AF.request(endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoder: URLEncodedFormParameterEncoder(destination: .queryString))
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let dto):
                completion(.success(dto))
            case .failure(let error):
                completion(.failure(.invalid))
            }
        }
    }
}

enum NetworkError: Error {
    case decode
    case invalid
    
    var message: String {
        switch self {
        case .decode: return "디코딩 에러"
        case .invalid: return "알 수 없는 에러"
        }
    }
}
