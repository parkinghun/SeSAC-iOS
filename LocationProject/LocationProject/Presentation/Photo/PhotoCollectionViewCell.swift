//
//  PhotoCollectionViewCell.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell: UICollectionViewCell, ReusableView {
    
    let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
    
    private func configureHierachy() {
        contentView.addSubview(imageView)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func configureView() {
    }
}
