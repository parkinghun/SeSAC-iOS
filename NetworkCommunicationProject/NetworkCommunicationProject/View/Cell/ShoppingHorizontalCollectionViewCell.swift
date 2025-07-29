//
//  ShoppingHorizontalCollectionViewCell.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/29/25.
//

import UIKit
import SnapKit

final class ShoppingHorizontalCollectionViewCell: UICollectionViewCell {
    
    static let id = "ShoppingHorizontalCollectionViewCell"
    
    let productImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierachy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item data: Product) {
        productImageView.downSampling(url: data.imageURL)
    }
}

extension ShoppingHorizontalCollectionViewCell: ViewDesignProtocol {
    func configureHierachy() {
        contentView.addSubview(productImageView)
    }
    
    func configureLayout() {
        productImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func configureView() {
        self.backgroundColor = .clear
    }
}
