//
//  Storyboarded.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit

protocol Storyboarded {
    static func instantiate(sb: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(sb: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
