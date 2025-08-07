//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum BMIValidationError: Error {
    case outOfRangeHeight
    case outOfRangeWeight
    case isNotDouble
    case blankSpace
    
    var message: String {
        switch self {
        case .outOfRangeHeight:
            return "입력하신 정보가 키의 범위를 벗어났습니다."
        case .outOfRangeWeight:
            return "입력하신 정보가 몸무게의 범위를 벗어났습니다."
        case .isNotDouble:
            return "숫자가 아닙니다. 키와 몸무게를 입력해주세요."
        case .blankSpace:
            return "키와 몸무게 모두 입력해주세요."
        }
    }
}


class BMIViewController: UIViewController {
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요 (80 ~ 230 cm)"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요 (20 ~ 160 kg)"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.numberOfLines = 2
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
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
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
    
    @objc func resultButtonTapped() {
        
        do {
            guard let heightText = heightTextField.text,
                  let weightText = weightTextField.text else { return }
            
            let input = try validateBMIInput(height: heightText, weight: weightText)
            let bmi = calculateBMI(height: input.height, weight: input.weight)
            let state = getBMIInfo(bmi: bmi)
            
            resultLabel.text = "BMI 지수: \(bmi) \n\(state)"
            
        } catch let error {
            resultLabel.text = "입력 에러! 다시 입력해주세요."
            
            let alert = UIAlertController(title: "BMI 입력 에러", message: error.message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
        
        resetInput()
        view.endEditing(true)
    }
    
    private func resetInput() {
        heightTextField.text = ""
        weightTextField.text = ""
        
        heightTextField.becomeFirstResponder()
    }
    
    private func validateBMIInput<T: StringProtocol>(height: T, weight: T) throws(BMIValidationError) -> (height: Double, weight: Double) {
        guard !height.isEmpty, !weight.isEmpty else {
            throw .blankSpace
        }
        
        guard let height = Double(height),
              let weight = Double(weight) else {
            throw .isNotDouble
        }

        guard height >= 80, height <= 230 else {  // 키: 80 ~ 230
            throw .outOfRangeHeight
        }
        
        guard weight >= 20, weight <= 160 else {  // 몸무게: 20 ~ 160
            throw .outOfRangeWeight
        }
        
        return (height, weight)
    }
    
    private func calculateBMI(height: Double, weight: Double) -> Double {
        var bmi = weight / (height * height) * 10000
        bmi = round(bmi * 10) / 10
        print("BMI결과값: \(bmi)")
        return bmi
    }
    
    private func getBMIInfo(bmi: Double) -> String{
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과제중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
}
