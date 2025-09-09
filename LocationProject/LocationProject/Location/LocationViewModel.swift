//
//  LocationViewModel.swift
//  LocationProject
//
//  Created by 박성훈 on 9/9/25.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

final class LocationViewModel {
    struct Input {
        let locationButtonTapped: ControlEvent<Void>
        let resetButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        
    }
    
    private let disposeBag = DisposeBag()
    let sesacCoordinate = CLLocationCoordinate2D(latitude: 37.519485, longitude: 126.890398)

    init () { }
    
    func transform(intput: Input) -> Output {
        
        NetworkManager.shared.request()
        
        return Output()
    }
}

extension LocationViewModel {
    
}
