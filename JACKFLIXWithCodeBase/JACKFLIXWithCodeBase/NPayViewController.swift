//
//  NPayViewController.swift
//  JACKFLIXWithCodeBase
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit
import SnapKit

final class NPayViewController: UIViewController {
    
    typealias DS = DesignSystem
    
    let membershipButton = UIButton.configureButton(title: "멤버십", titleColor: .secondaryLabel, font: DS.Font.title3, bgColor: .black)
    let payButton = UIButton.configureButton(title: "현장결제", titleColor: .white, font: DS.Font.title3, bgColor: .darkGray)
    let cuponButton = UIButton.configureButton(title: "쿠폰", titleColor: .secondaryLabel, font: DS.Font.title3, bgColor: .black)
    
    lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [membershipButton, payButton, cuponButton])
        sv.axis = .horizontal
        sv.spacing = 0
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.backgroundColor = .black
        
        return sv
    }()
    
    let payWrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setCorner(radius: DS.Radius.large)
        return view
    }()
    
    let nPayLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nPayLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let countryButton: UIButton = {
       let bt = UIButton()
        bt.configure(title: "국내 ▾", titleColor: .secondaryLabel)
        return bt
    }()
    
    let dismissButton: UIButton = {
        let bt = UIButton()
        bt.configure(image: UIImage(systemName: "xmark"), tintColor: .gray)
        return bt
    }()
    
    let centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nPayCenter")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let announceLabel: UILabel = {
       let label = UILabel()
        label.configure(text: "한 번만 인증하고\n비밀번호 없이 결제하세요",
                        font: DS.Font.title2,
                        numberOfLines: 2,
                        alignment: .center)
        return label
    }()
    
    let checkButton: UIButton = {
       let bt = UIButton()
        bt.configure(title: "바로결제 사용하기", titleColor: .black, image: UIImage(systemName: "checkmark.circle.fill"), tintColor: .green)
        return bt
    }()
    
    let confirmButton: UIButton = {
        let bt = UIButton()
        bt.configure(title: "확인", titleColor: .white, bgColor: .green)
         return bt
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCapsule()
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
        view.addSubview(buttonStackView)
        view.addSubview(payWrapperView)
        
        payWrapperView.addSubview(nPayLogoImageView)
        payWrapperView.addSubview(countryButton)
        payWrapperView.addSubview(dismissButton)
        payWrapperView.addSubview(centerImageView)
        payWrapperView.addSubview(announceLabel)
        payWrapperView.addSubview(checkButton)
        payWrapperView.addSubview(confirmButton)
    }
    
    private func setConstraints() {
        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view).inset(DS.Spacing.regular)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(DS.Spacing.large)
            $0.height.equalTo(44)
        }
        
        payWrapperView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view).inset(DS.Spacing.regular)
            $0.top.equalTo(buttonStackView.snp.bottom).offset(DS.Spacing.medium)
            $0.height.equalTo(view).multipliedBy(0.5)
        }
        
        nPayLogoImageView.snp.makeConstraints {
            $0.top.leading.equalTo(payWrapperView).offset(DS.Spacing.regular)
            $0.size.equalTo(CGSize(width: 60, height: 44))
        }
        
        countryButton.snp.makeConstraints {
            $0.top.equalTo(nPayLogoImageView)
            $0.leading.equalTo(nPayLogoImageView.snp.trailing).offset(DS.Spacing.small)
            $0.size.equalTo(CGSize(width: 50, height: 44))
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.trailing.equalTo(payWrapperView).inset(DS.Spacing.regular)
            $0.size.equalTo(44)
        }
        
        centerImageView.snp.makeConstraints {
            $0.top.equalTo(payWrapperView).offset(60)
            $0.centerX.equalTo(payWrapperView)
            $0.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        announceLabel.snp.makeConstraints {
            $0.top.equalTo(centerImageView.snp.bottom).offset(DS.Spacing.large)
            $0.centerX.equalTo(payWrapperView)
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(confirmButton.snp.top).offset(-30)
            $0.centerX.equalTo(payWrapperView)
        }
        
        confirmButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(payWrapperView).inset(20)
            $0.height.equalTo(44)
        }
    }
    
    private func configureCapsule() {
        buttonStackView.setCorner(radius: buttonStackView.frame.height / 2)
        payButton.setCorner(radius: payButton.frame.height / 2)
        confirmButton.setCorner(radius: confirmButton.frame.height / 2)
    }
}
