//
//  ShoppingSearchView.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import UIKit
import SnapKit

final class ShoppingSearchView: UIView {
    
    typealias DSFont = DesignSystem.Font
    
    let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    let mainImageView = {
        let imageView = UIImageView()
        imageView.image = .shoppingMan
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let shoppingLabel = {
        let label = UILabel()
        label.configure(text: "쇼핑하구팡", font: DSFont.body, color: .white)
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
}

extension ShoppingSearchView: ViewDesignProtocol {
    func configureHierachy() {
        self.addSubview(searchBar)
        self.addSubview(mainImageView)
        self.addSubview(shoppingLabel)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.horizontalEdges.equalTo(self).inset(12)
            $0.height.equalTo(44)
        }
        
        mainImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self).inset(20)
            $0.centerY.equalTo(self)
            $0.height.equalTo(300)
        }
        
        shoppingLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(self)
        }
    }
    
    func configureView() {
        self.backgroundColor = .black
    }
}
