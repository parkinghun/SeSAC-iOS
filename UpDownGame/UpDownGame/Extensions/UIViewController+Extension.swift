//
//  UIViewController+Extension.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/22/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}
