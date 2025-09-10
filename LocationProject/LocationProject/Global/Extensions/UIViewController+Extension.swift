//
//  UIViewController+Extension.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let preferredStyle: UIAlertController.Style
    let type: AlertType
    
    enum AlertType {
        case ok
        case okCancel
    }
}

extension UIViewController {
    
    func showAlert(_ model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: model.preferredStyle)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        if model.type == .okCancel {
            let cancel = UIAlertAction(title: "취소", style: .default)
            alert.addAction(cancel)
        }
        
        self.present(alert, animated: true)
    }
}
