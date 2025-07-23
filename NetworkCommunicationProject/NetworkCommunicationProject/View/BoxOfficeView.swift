//
//  BoxOfficeView.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/24/25.
//

import UIKit
import SnapKit

protocol BoxOfficeViewDelegate: AnyObject {
    func tappedSearchButton()
}

final class BoxOfficeView: UIView {
    
    weak var delegate: BoxOfficeViewDelegate?
    
    let searchTextField = {
        let textField = UITextField()
        textField.placeholder = "영화를 검색해주세요"
        textField.textColor = .white
        textField.borderStyle = .none
        return textField
    }()
    
    let textFieldUnderLineView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let searchButton = {
        let bt = UIButton()
        bt.setTitle("검색", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.titleLabel?.font = DesignSystem.Font.callout
        bt.backgroundColor = .white
        return bt
    }()
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureView()
        setupActoin()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActoin() {
        searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
    }
    
    @objc private func tappedSearchButton() {
        delegate?.tappedSearchButton()
    }
}

extension BoxOfficeView: ViewDesignProtocol {
    func configureHierachy() {
        self.addSubview(searchTextField)
        self.addSubview(textFieldUnderLineView)
        self.addSubview(searchButton)
        self.addSubview(tableView)
    }
    
    func configureLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
        }
        
        textFieldUnderLineView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(searchTextField)
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.height.equalTo(2)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-16)
            $0.top.equalTo(searchTextField)
            $0.bottom.equalTo(textFieldUnderLineView)
            $0.width.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(textFieldUnderLineView.snp.bottom).offset(12)
        }
    }
    
    func configureView() {
        backgroundColor = .black
        tableView.backgroundColor = .clear
    }
}

