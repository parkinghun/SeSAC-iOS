//
//  Coordinator.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func stop()
}
