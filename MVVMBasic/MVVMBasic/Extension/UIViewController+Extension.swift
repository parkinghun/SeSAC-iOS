//
//  UIViewController+Extension.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/7/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionHandler: (() -> Void)? = nil)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            actionHandler?()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
