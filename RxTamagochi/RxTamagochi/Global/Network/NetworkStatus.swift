//
//  NetworkRouter.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/26/25.
//

import Alamofire
import RxSwift
import Foundation

class Connectivity {
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

enum NetworkSatusType {
    case disconnect
    case connect
    case unknown
}

// NSObject가 없으면 extension Reactive를 해도 rx 네임스페이스 사용 불가
final class NetworkSatus: NSObject {
    static let shared = NetworkSatus()
    fileprivate let behaviorPublish = BehaviorSubject<NetworkSatusType>(value: .connect)
    
    var statusObservable: Observable<NetworkSatusType> {
        behaviorPublish
            .debug()
    }
    
    private override init() {
        super.init()
        observeReactability()
    }
    
    private func observeReactability() {
        let reachability = NetworkReachabilityManager()
        reachability?.startListening { [weak behaviorPublish] status in
            switch status {
            case .notReachable:
                behaviorPublish?.onNext(.disconnect)
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                behaviorPublish?.onNext(.connect)
            case .unknown:
                behaviorPublish?.onNext(.unknown)
            }
        }
    }
}

// NetworkService + Rx
extension Reactive where Base: NetworkSatus {
    var isNetworkConnected: Observable<Bool> {
        let status = (try? base.behaviorPublish.value()) ?? .unknown
        guard case .connect = status else { return .just(false)}
        return .just(true)
    }
}
