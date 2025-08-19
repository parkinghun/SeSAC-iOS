//
//  UIViewController+Extension.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/19/25.
//

import UIKit

extension UIViewController {
    func presentAlert(_ message: String) {
        let alertView = UIAlertController(title: "RxExample", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
        })
        rootViewController().present(alertView, animated: true, completion: nil)
    }
    
    private func rootViewController() -> UIViewController {
        return self.view.window?.rootViewController ?? UIViewController()
    }
}
