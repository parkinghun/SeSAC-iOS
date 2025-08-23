//
//  UIViewController.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/23/25.
//

import UIKit

extension UIViewController {
    func showAlert(alertStyle: AlertStyle) {
        let alert = UIAlertController(title: alertStyle.title, message: alertStyle.message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: alertStyle.ok, style: .default) { _ in
            alertStyle.handler?()
        }
        let cancel = UIAlertAction(title: alertStyle.cancel, style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
