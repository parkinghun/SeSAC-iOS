//
//  NetworkRouter.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/26/25.
//

import Alamofire
import RxSwift

//enum NetworkRouter {
//    case lotto
//    case boxOffice
//    
////    var baseURL: String {
////        
////    }
//}

enum NetworkSatusType {
    case disconnect
    case connect
    case unknown
}

final class NetworkSatus {
    static let shared = NetworkSatus()
    fileprivate let statusPublish = PublishSubject<NetworkSatusType>()
    
    var statusObject: Observable<NetworkSatusType> {
        statusPublish
            .debug()
    }
    
    private init() {
        observeReactability()
    }
    
    private func observeReactability() {
        let reachability = NetworkReachabilityManager()
        reachability?.startListening { [weak statusPublish] status in
            switch status {
            case .notReachable:
                statusPublish?.onNext(.disconnect)
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                statusPublish?.onNext(.connect)
            case .unknown:
                statusPublish?.onNext(.unknown)
            }
        }
    }
}
