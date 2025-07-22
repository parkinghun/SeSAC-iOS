//
//  UIViewController+Extension.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/22/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController()
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}
