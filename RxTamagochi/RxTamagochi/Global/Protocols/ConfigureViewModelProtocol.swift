//
//  SetViewModelProtocol.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/22/25.
//

import Foundation

protocol ConfigureViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
