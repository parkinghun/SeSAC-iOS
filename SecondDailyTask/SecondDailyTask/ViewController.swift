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
    
    @IBOutlet var emailValidationLabel: UILabel!
    @IBOutlet var passwordValidationLabel: UILabel!
    @IBOutlet var nicknameValidationLabel: UILabel!
    @IBOutlet var locationValidationLabel: UILabel!
    @IBOutlet var referralCodeValidationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAttributes()
    }
    
    private func setDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nicknameTextField.delegate = self
        locationTextField.delegate = self
        referralCodeTextField.delegate = self
    }
    
    private func setAttributes() {
        self.view.backgroundColor = .black
        
        logoLabel.text = "JACKFLIX"
        logoLabel.textColor = .red
        logoLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        emailTextField.setUI(placeholder: "이메일 또는 전화번호", keyboardType: .emailAddress)
        passwordTextField.setUI(placeholder: "비밀번호", isSecure: true)
        passwordTextField.textContentType = .oneTimeCode
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
        
        emailValidationLabel.setUI(text: "올바른 이메일 혹은 전화번호를 입력해주세요..")
        passwordValidationLabel.setUI(text: "비밀번호는 8자리~13자리 영어+숫자+특수문자를 포함하세요.")
        nicknameValidationLabel.setUI(text: "닉네임은 2자 이상 입력해주세요.")
        locationValidationLabel.setUI(text: "위치를 입력해주세요.")
        referralCodeValidationLabel.setUI(text: "올바른 추천코드를 입력해주세요. (영문 6자)")
    }
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        if emailTextField.text?.isValidEmail ?? false || emailTextField.text?.isValidPhoneNumber ?? false {
            emailValidationLabel.text = "올바른 형식입니다."
            emailValidationLabel.textColor = .white
        } else {
            emailValidationLabel.text = "올바른 이메일 혹은 전화번호를 입력해주세요."
            emailValidationLabel.textColor = .red
        }
    }
   
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        print("\(sender.tag) 바뀜")
        if passwordTextField.text?.isValidPassword ?? false {
            passwordValidationLabel.text = "올바른 형식입니다"
            passwordValidationLabel.textColor = .white
        } else {
            passwordValidationLabel.text = "비밀번호는 8자리~13자리 영어+숫자+특수문자를 포함하세요."
            passwordValidationLabel.textColor = .red
        }
    }
    
    @IBAction func nicknameTextFieldEditingChanged(_ sender: UITextField) {
        print("\(sender.tag) 바뀜")
        if nicknameTextField.text?.count ?? 0 >= 2 {
            nicknameValidationLabel.text = "올바른 형식입니다"
            nicknameValidationLabel.textColor = .white
        } else {
            nicknameValidationLabel.text = "닉네임은 2자 이상 입력해주세요."
            nicknameValidationLabel.textColor = .red
        }
    }
    
    @IBAction func locationTextFieldEditingChanged(_ sender: UITextField) {
        print("\(sender.tag) 바뀜")
        if locationTextField.text?.count ?? 0 >= 1 {
            locationValidationLabel.text = "올바른 형식입니다"
            locationValidationLabel.textColor = .white
        } else {
            locationValidationLabel.text = "위치를 입력해주세요."
            locationValidationLabel.textColor = .red
        }
    }
    
    @IBAction func referralTextFieldEditingChanged(_ sender: UITextField) {
        print("\(sender.tag) 바뀜")
        if referralCodeTextField.text?.isValidCode ?? false {
            referralCodeValidationLabel.text = "올바른 형식입니다"
            referralCodeValidationLabel.textColor = .white
        } else {
            referralCodeValidationLabel.text = "올바른 추천코드를 입력해주세요. (영문 6자)."
            referralCodeValidationLabel.textColor = .red
        }
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
