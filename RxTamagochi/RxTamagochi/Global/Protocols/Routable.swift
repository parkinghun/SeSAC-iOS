//
//  Routable.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import UIKit

protocol Routable {
    func setRoot(_ vc: UIViewController, animated: Bool)
    func push(_ vc: UIViewController, animated: Bool)
    func present(_ vc: UIViewController, animated: Bool)
    func pop(animated: Bool)
}
