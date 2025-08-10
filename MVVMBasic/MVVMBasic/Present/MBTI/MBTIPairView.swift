//
//  MBTIPairView.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/10/25.
//

import UIKit
import SnapKit

final class MBTIPairView<T: RawRepresentable & CaseIterable>: UIView where T.RawValue == String {
    
    let topBT = MBTIButton()
    let bottomBT = MBTIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: T.Type) {
        self.init(frame: .zero)
        
        let mbtiCases = Array(T.allCases)
        
        topBT.setTitle(mbtiCases[0].rawValue, for: .normal)
        bottomBT.setTitle(mbtiCases[1].rawValue, for: .normal)
    }
    
    private func configureHierachy() {
        self.addSubview(topBT)
        self.addSubview(bottomBT)
    }
    
    private func configureLayout() {
        topBT.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(44)
        }
        
        bottomBT.snp.makeConstraints { make in
            make.top.equalTo(topBT.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.size.equalTo(44)
        }
    }
    
    private func configureView() {
        topBT.layer.cornerRadius = 22
        bottomBT.layer.cornerRadius = 22
    }
}
