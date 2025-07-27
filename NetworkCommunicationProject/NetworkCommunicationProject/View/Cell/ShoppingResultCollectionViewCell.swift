//
//  ShoppingResultCollectionViewCell.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/26/25.
//

import UIKit


final class ShoppingResultCollectionViewCell: UICollectionViewCell {
    
    typealias DSFont = DesignSystem.Font
    static let id = "ShoppingResultCollectionViewCell"

    let imageWrapperView = UIView()

    let productImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()

    let likeButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "heart"), for: .normal)
        bt.tintColor = .black
        bt.backgroundColor = .white
        bt.imageView?.contentMode = .scaleAspectFill
        return bt
    }()

    let mallLabel = {
        let label = UILabel()
        label.configure(font: DSFont.caption1, color: .gray)
        return label
    }()

    let titleLable = {
        let label = UILabel()
        label.configure(font: DSFont.footnote, color: .white, numberOfLines: 2)
        return label
    }()

    let priceLabel = {
        let label = UILabel()
        label.configure(font: DSFont.title3Bold, color: .white)
        return label
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.likeButton.layer.cornerRadius = likeButton.frame.width / 2
            self.likeButton.clipsToBounds = true
        }
    }
    
    func configure(item data: Product) {
        productImageView.downSampling(url: data.imageURL)
        mallLabel.text = data.mallName
        titleLable.text = data.title
        priceLabel.text = data.formattedPrice
    }
}

extension ShoppingResultCollectionViewCell: ViewDesignProtocol {
    func configureHierachy() {
        let components: [UIView] = [imageWrapperView, mallLabel, titleLable, priceLabel]
        
        components.forEach {
            contentView.addSubview($0)
        }
        
        imageWrapperView.addSubview(productImageView)
        imageWrapperView.addSubview(likeButton)
    }
    
    func configureLayout() {
        imageWrapperView.snp.makeConstraints {
            $0.width.height.equalTo(contentView.snp.width)
            $0.top.equalTo(contentView)
        }
        
        productImageView.snp.makeConstraints {
            $0.edges.equalTo(imageWrapperView)
        }
        
        likeButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(imageWrapperView).inset(8)
            $0.size.equalTo(44)
        }
        
        mallLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(12)
            $0.top.equalTo(imageWrapperView.snp.bottom).offset(4)
        }
        
        titleLable.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(12)
            $0.top.equalTo(mallLabel.snp.bottom).offset(6)
        }
        
        priceLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(12)
            $0.top.equalTo(titleLable.snp.bottom).offset(6)
        }
    }
    
    func configureView() {
        self.backgroundColor = .clear
    }
}
