//
//  MBTIView.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/13/25.
//

import UIKit
import SnapKit

final class MBTIView: UIView {
    var mbti = ["E", "I", "S", "N", "T", "F", "J", "P"]
    
    var buttons: [MBTIButton] = []
    
    var closure: ((Int) -> Void)?
    
    let hStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBT(index: Int) {
        buttons[index].setSelected(true)  // true -> toggle
        
        if index % 2 == 0 {
            buttons[index + 1].setSelected(false)
        } else {
            buttons[index - 1].setSelected(false)
        }
        
    }
}

private extension MBTIView {
    func configureHierachy() {
        self.addSubview(hStackView)
    }
    
    func configureLayout() {
        hStackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupButtons() {
        let rowCount = 2
        let colCount = 4
        
        for col in 0..<colCount {
            let vStackView = makeVStack()
            
            for row in 0..<rowCount {
                let index = (col * rowCount) + row
                
                let bt = MBTIButton(title: mbti[index], tag: index)
                buttons.append(bt)
                bt.addTarget(self, action: #selector(mbtiButtonTapped(_:)), for: .touchUpInside)
                bt.snp.makeConstraints { make in
                    make.size.equalTo(44)
                }
                vStackView.addArrangedSubview(bt)
            }
            hStackView.addArrangedSubview(vStackView)
        }
    }
    
    func makeVStack() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }
    
    @objc func mbtiButtonTapped(_ sender: UIButton) {
        print(#function)
        print(sender.tag)
        closure?(sender.tag)
    }
}
