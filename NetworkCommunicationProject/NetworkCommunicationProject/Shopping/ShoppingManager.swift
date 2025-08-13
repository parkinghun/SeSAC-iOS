//
//  NetworkManager.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 8/12/25.
//

import Foundation
import Alamofire

final class ShoppingManager {
    static let shared = ShoppingManager()
    
    private init() { }
        
    func callRequest<T: Decodable>(api: ShoppingRouter, type: T.Type, completion: @escaping (Result<SearchResult, ShoppingAPIError>) -> Void) {
        
        AF.request(api.enidPoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: api.headers)
            .responseDecodable(of: SearchResult.self) { response in
                switch response.result {
                case let .success(value):
                    completion(.success(value))
                case .failure(_):
                    do {
                        guard let data = response.data else { return }
                        let errorEntity = try JSONDecoder().decode(ShoppingErrorEntity.self, from: data)
                        
                        completion(.failure(self.mapError(errorEntity)))
                        
                    } catch {
                        print(completion(.failure(.decodingError)))
                    }
                }
            }
    }
    
    private func mapError(_ entity: ShoppingErrorEntity) -> ShoppingAPIError {
        switch entity.errorCode {
        case "SE01": return .incorrectQueryRequest
        case "SE02": return .invalidDisplayValue
        case "SE03": return .invalidStartValue
        case "SE04": return .invalidSortValue
        case "SE06": return .malformedEncoding
        case "SE05": return .invalidSearchAPI
        case "SE99": return .systemError
        default: return .unknownError(code: entity.errorCode)
        }
    }
}

extension ShoppingManager {
    enum ShoppingAPIError: Error {
        case incorrectQueryRequest    // SE01
        case invalidDisplayValue      // SE02
        case invalidStartValue        // SE03
        case invalidSortValue         // SE04
        case malformedEncoding        // SE06
        case invalidSearchAPI         // SE05
        case systemError              // SE99
        case networkError(Error)      // 네트워크 자체 오류
        case decodingError            // JSON 파싱 실패
        case unknownError(code: String)  // 문서에 없는 에러 코드
        
        var message: String {
            switch self {
            case .incorrectQueryRequest:
                return "잘못된 쿼리요청입니다."
            case .invalidDisplayValue:
                return "부적절한 display 값입니다."
            case .invalidStartValue:
                return "부적절한 start 값입니다."
            case .invalidSortValue:
                return "부적절한 sort 값입니다."
            case .malformedEncoding:
                return "잘못된 형식의 인코딩입니다."
            case .invalidSearchAPI:
                return "존재하지 않는 검색 api 입니다."
            case .systemError:
                return "시스템 에러"
            case let .networkError(error):
                return "네트워크 오류가 발생했습닌다. \(error.localizedDescription)"
            case .decodingError:
                return "디코딩 에러 데이터를 처리할 수 없습니다."
            case let .unknownError(code):
                return "알 수 없는 오류가 발생했습니다. (코드: \(code))"
            }
        }
    }
}
