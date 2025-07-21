//
//  ViewController.swift
//  JACKFLIXWithCodeBase
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit
import SnapKit

class JackFlixViewController: UIViewController {
    
    typealias DS = DesignSystem
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.configure(text: "JACKFLIX", font: DS.Font.title1, color: .red)
        return label
    }()
    
    let emailTextField = UITextField.makeConfigured(placeholder: "이메일 주소 또는 전화번호")
    let passwordTextField = UITextField.makeConfigured(placeholder: "비밀번호")
    let nicknameTextField = UITextField.makeConfigured(placeholder: "닉네임")
    let locationTextField = UITextField.makeConfigured(placeholder: "위치")
    let referralCodeTextField = UITextField.makeConfigured(placeholder: "추천 코드 입력")
    
    let signupButton: UIButton = {
        let bt = UIButton()
        bt.configure(title: "회원가입", titleColor: .black, bgColor: .white, corderRadius: DS.Radius.medium)
        return bt
    }()
    
    lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, nicknameTextField, locationTextField, referralCodeTextField, signupButton])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = DS.Spacing.small
        return sv
    }()
    
    let additionalInfoLabel: UILabel = {
       let label = UILabel()
        label.configure(text: "추가 정보 입력", color: .white)
        return label
    }()
    
    let infoSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = true
        uiSwitch.onTintColor = .red
        return uiSwitch
    }()
    
    let tapGestupre = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureView()
        configureHierarchy()
        setConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = DS.Color.bgColor
    }
    
    private func configureHierarchy() {
        view.addSubview(logoLabel)
        view.addSubview(textFieldStackView)
        view.addSubview(additionalInfoLabel)
        view.addSubview(infoSwitch)
        
    }
    
    private func setConstraints() {
        let textFields = [emailTextField, passwordTextField, nicknameTextField, locationTextField, referralCodeTextField]
        
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(DS.Spacing.large)
            $0.centerX.equalTo(view)
        }
        
        textFields.forEach {
            $0.snp.makeConstraints { $0.height.equalTo(36) }
        }
        
        signupButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view).inset(DS.Spacing.regular)
            $0.centerY.equalTo(view)
        }
        
        additionalInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(view).offset(DS.Spacing.regular)
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(DS.Spacing.medium)
        }
        
        infoSwitch.snp.makeConstraints {
            $0.trailing.equalTo(view).offset(-DesignSystem.Spacing.regular)
            $0.top.equalTo(additionalInfoLabel)
        }
    }
}

