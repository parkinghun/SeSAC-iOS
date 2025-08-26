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
        alert.addAction(ok)
        
        if let _ = alertStyle.cancel {
            let cancel = UIAlertAction(title: alertStyle.cancel, style: .cancel)
            alert.addAction(cancel)
        }
        
        present(alert, animated: true)
    }
    
    func showToastMessage(_ toast: Toast) {
        let toastView = ToastMessageView()
        toastView.configure(message: toast.message, status: toast.status)

        self.view.addSubview(toastView)
        
        toastView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(44)
        }
        
        UIView.animate(withDuration: 5.0) {
            toastView.alpha = 0.0
        } completion: { _ in
            toastView.removeFromSuperview()
        }
    }
}
