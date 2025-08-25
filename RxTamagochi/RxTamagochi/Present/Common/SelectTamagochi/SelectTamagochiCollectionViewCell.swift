//
//  SelectTamagochiCollectionViewCell.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit
import SnapKit
final class SelectTamagochiCollectionViewCell: UICollectionViewCell, ReuseViewProtocol {
    
    let tamagochiView = TamagochiView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierachy() {
        contentView.addSubview(tamagochiView)
    }
    
    func configureLayout() {
        tamagochiView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
