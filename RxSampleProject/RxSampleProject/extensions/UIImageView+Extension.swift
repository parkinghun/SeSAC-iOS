//
//  UIImageView+Extension.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/20/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downSampling(url: URL?, size: CGSize = CGSize(width: 60, height: 60)) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            options: [
                .processor(DownsamplingImageProcessor(size: size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
    }
}
