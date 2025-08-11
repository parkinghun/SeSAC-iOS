//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

final class BMIViewController: UIViewController {
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요 (80 ~ 230 cm)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요 (20 ~ 160 kg)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    private let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let viewModel = BMIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        
        viewModel.outputResult.bind { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let text):
                self.resultLabel.text = text
            case .failure(let error):
                self.showAlert(title: "BMI Error", message: error.message) {
                    self.resetInput()
                }
            }
        }
    }
    
    private func configureHierarchy() {
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    private func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @objc private func resultButtonTapped() {
        viewModel.inputTexts.value = (heightTextField.text, weightTextField.text)
        view.endEditing(true)
    }
    
    private func resetInput() {
        heightTextField.text = ""
        weightTextField.text = ""
        
        heightTextField.becomeFirstResponder()
    }
}
