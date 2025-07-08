//
//  BMIViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 박성훈 on 7/4/25.
//

import UIKit

class BMIViewController: UIViewController {
    
    var bmiInputError: BMIInputError = .emptyInput
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var weightStckView: UIStackView!
    @IBOutlet var secureButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var bmiStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        setTextField()
        configureButton(randomButton, title: "랜덤으로 BMI 계산하기", titleColor: .red)
        configureButton(resultButton, title: "결과 확인",
                        titleColor: .white,
                        backgroundColor: .purple,
                        cornerRadius: 10)
        configureLabel(resultLabel)
        configureLabel(bmiStateLabel)
    }
    
    private func setTextField() {
        setRadius(heightTextField)
        setRadius(weightStckView)
        weightTextField.borderStyle = .none
        configureButton(secureButton, title: "")
        secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        secureButton.tintColor = .gray
    }
    
    private func configureLabel(_ label: UILabel, text: String = "", alignment: NSTextAlignment = .center) {
        label.text = text
        label.textAlignment = alignment
    }
    
    private func configureButton(_ button: UIButton, title: String, titleColor: UIColor = .black, backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        
        if cornerRadius != 0 {
            setRadius(button, cornerRadius: cornerRadius)
        }
    }
    
    private func setRadius(_ view: UIView, cornerRadius: CGFloat = 8, borderWidth: CGFloat = 2, borderColor: CGColor = UIColor.gray.cgColor) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
    
    @IBAction func secureButtonTapped(_ sender: UIButton) {
        print(#function)
        weightTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        print(#function)
        calculateBMIRandomly()
    }
    
    private func calculateBMIRandomly() {
        let height: Double = Double.random(in: 0...300)
        let weight: Double = Double.random(in: 0...300)
        
        heightTextField.text = String((height * 10).rounded() / 10)
        weightTextField.text = String((weight * 10).rounded() / 10)
        
        calculateBMI(height: height, weight: weight)
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        print(#function)
        
        guard let (height, weight) = isValidate() else { return }
        calculateBMI(height: height, weight: weight)
    }
    
    
    private func showAlert(error: BMIInputError) {
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    private func calculateBMI(height: Double, weight: Double) {
        let bmi = weight / (height * height / 10000) // 의미단위, 변수
        resultLabel.text = "BMI: \((bmi * 10).rounded() / 10)"
        
        let state = BMIState.getState(for: bmi)
        bmiStateLabel.text = state.description
        bmiStateLabel.textColor = state.color
        
        print(bmi)
    }
    
    private func isValidate() -> (height: Double, weight: Double)? {
        guard let heightText = heightTextField.text,
              let weightText = weightTextField.text else {
            showAlert(error: .emptyInput)
            return nil
        }
        
        guard !heightText.isEmpty, !weightText.isEmpty else {
            showAlert(error: .emptyInput)
            return nil
        }
        
        guard let height = Double(heightText),
              let weight = Double(weightText) else {
            showAlert(error: .nonNumericInput)
            return nil
        }
        
        guard (0...300).contains(height), (0...300).contains(weight) else {
            showAlert(error: .invalidRange)
            return nil
        }
        
        return (height, weight)
    }
}
