//
//  BoxOfficeViewMdoel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class BoxOfficeViewModel: ConfigureViewModelProtocol {
    struct Input { }
    struct Output { }
    
    var disposeBag = DisposeBag()

    init() { }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
