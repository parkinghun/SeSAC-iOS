//
//  SetViewModelProtocol.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/22/25.
//

import Foundation
import RxSwift

protocol ConfigureViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
