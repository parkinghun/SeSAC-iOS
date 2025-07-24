//
//  UIViewController+Extension.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/24/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okActoin = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okActoin)
            
        present(alert, animated: true)
    }
}
