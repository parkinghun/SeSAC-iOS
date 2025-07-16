//
//  UIView+Extension.swift
//  TravelProject
//
//  Created by 박성훈 on 7/16/25.
//

import UIKit

extension UIView {
    static func loadingIndicatorView(size: CGSize = CGSize(width: 50, height: 50)) -> UIView {
        let container = UIView(frame: CGRect(origin: .zero, size: size))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.center = CGPoint(x: size.width / 2, y: size.height / 2)
        spinner.startAnimating()
        container.addSubview(spinner)
        return container
    }
}
