//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum AgeValidationError: Error {
    case outOfRange  // 범위밖
    case blankSpace  // 공백
    case isNotInt  // 문자열
    
    var message: String {
        switch self {
        case .outOfRange:
            return "입력하신 내용이 범위를 벗어났습니다. 1~100세까지 입력해주세요."
        case .blankSpace:
            return "빈 문자를 입력하셨습니다. 나이를 입력해주세요."
        case .isNotInt:
            return "숫자가 아닙니다. 나이를 입력해주세요."
        }
    }
}

// TODO: - 1~100세 범위의 내용이 기입되지 않은 경우 처리
class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        print(#function)
        do {
            guard let input = textField.text else { return }
            let age = try validateAgeInput(text: input)
            
            label.text = age
        } catch let error {
            print(error.localizedDescription)
            label.text = error.message
        }
        
        view.endEditing(true)
    }
    
    private func validateAgeInput(text: String) throws(AgeValidationError) -> String {
        guard !text.isEmpty else {  // 공백
            throw .blankSpace
        }
        
        guard let age = Int(text) else {  //문자열
            throw .isNotInt
        }
        
        guard !(0...100).contains(age) else {  // 나이 범위
            throw .outOfRange
        }
        
        return text
    }
}
