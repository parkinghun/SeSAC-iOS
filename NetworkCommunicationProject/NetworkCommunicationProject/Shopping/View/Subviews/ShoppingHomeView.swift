//
//  ShoppingHomeView.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/25/25.
//

import UIKit
import SnapKit

protocol ShoppingHomeViewDelegate: AnyObject {
    func tappedGoButton()
}

final class ShoppingHomeView: UIView {
    
    weak private var delegate: ShoppingHomeViewDelegate?
    
    let goButton = {
        let bt = UIButton()
        bt.setTitle("쇼핑하러 가기", for: .normal)
        bt.backgroundColor = .orange
        bt.layer.cornerRadius = 12
        bt.clipsToBounds = true
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureView()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ShoppingHomeViewDelegate을 채택하면 아규먼트로 가능
    func configureDelegation(_ delegate: ShoppingHomeViewDelegate) {
        self.delegate = delegate
    }
}

extension ShoppingHomeView: ViewDesignProtocol {
    func configureHierachy() {
        addSubview(goButton)
    }
    
    func configureLayout() {
        goButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
    }
    
    func configureView() {
        self.backgroundColor = .black
    }
    
    func configureButton() {
        goButton.addTarget(self, action: #selector(tappedGoButton), for: .touchUpInside)
    }
    
    @objc private func tappedGoButton() {
        delegate?.tappedGoButton()
    }
}
