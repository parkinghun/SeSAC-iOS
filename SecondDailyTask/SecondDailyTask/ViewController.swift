//
//  ViewController.swift
//  SecondDailyTask
//
//  Created by 박성훈 on 7/1/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var logoLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var referralCodeTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var additionalInformationLabel: UILabel!
    @IBOutlet var additionInformationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nicknameTextField.delegate = self
        locationTextField.delegate = self
        referralCodeTextField.delegate = self
    }
    
    private func setAttributes() {
        logoLabel.text = "JACKFLIX"
        logoLabel.textColor = .red
        logoLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        emailTextField.setUI(placeholder: "이메일 주소 또는 전화번호", keyboardType: .emailAddress)
        passwordTextField.setUI(placeholder: "비밀번호")
        nicknameTextField.setUI(placeholder: "닉네임")
        locationTextField.setUI(placeholder: "위치")
        referralCodeTextField.setUI(placeholder: "추천 코드 입력")
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 12
        signUpButton.clipsToBounds = true
        
        additionalInformationLabel.text = "추가 정보 입력"
        additionalInformationLabel.textColor = .white
        
        additionInformationSwitch.onTintColor = .red
        additionInformationSwitch.thumbTintColor = .gray
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        print("""
    이메일: \(emailTextField.text ?? "")
    비밀번호: \(passwordTextField.text ?? "")
    닉네임: \(nicknameTextField.text ?? "")
    위치: \(locationTextField.text ?? "")
    추천코드: \(referralCodeTextField.text ?? "")
    """)
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
