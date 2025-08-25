//
//  TamagochiView.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit
import SnapKit

final class TamagochiView: UIView {
    
    let thumbnailImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.tintColor = .blue
        label.layer.cornerRadius = 8
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(item tamagochi: TamagochiType) {
        thumbnailImageView.image = UIImage(named: tamagochi.thumbnail)
        titleLabel.text = tamagochi.title
    }
    
    func configureHierachy() {
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
    }
    
    func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(thumbnailImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}
