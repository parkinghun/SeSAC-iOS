//
//  NormalViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 박성훈 on 7/7/25.
//

import UIKit

class NormalViewController: UIViewController {

    @IBOutlet var segmentButtonStackView: UIStackView!
    @IBOutlet var segmentButtons: [UIButton]!
    
    @IBOutlet var naverPayLogoImageView: UIImageView!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var payButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    
    @IBOutlet var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.view.backgroundColor = .black
        setConerRadius(backgroundView, radius: 12)
        setConerRadius(segmentButtonStackView, radius: segmentButtonStackView.bounds.height / 2)
        setButton()
        descriptionLabel.text = "한 번만 인증하고\n비밀번호 없이 결제하세요."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func setConerRadius(_ view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }

    private func setButton() {
        for index in 0..<segmentButtons.count {
            segmentButtons[index].tag = index
        }
        
        segmentButtons.forEach { button in
            switch button.tag {
            case 0:
                setButton(button, title: "멤버십", titleColor: .darkGray, backgroundColor: .black)
            case 1:
                setButton(button, title: "현장결제", titleColor: .white, backgroundColor: .darkGray)
                setConerRadius(button, radius: button.bounds.height / 2)
            case 2:
                setButton(button, title: "쿠폰", titleColor: .darkGray, backgroundColor: .black)
            default: return
            }
        }
        
        setButton(locationButton, title: "국내▾", titleColor: .gray)
        setButton(cancelButton, image: UIImage(systemName: "xmark"), tintColor: .gray)
        setButton(payButton, title: " 바로결제 사용하기", image: UIImage(systemName: "checkmark.circle.fill"), tintColor: .green)
        setButton(confirmButton, title: "확인", titleColor: .white, backgroundColor: .green)
        setConerRadius(confirmButton, radius: confirmButton.bounds.height / 2)
    }
    
    private func setButton(_ button: UIButton, title: String = "", titleColor: UIColor = .black, image: UIImage? = nil, tintColor: UIColor = .black, backgroundColor: UIColor? = nil) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        button.backgroundColor = backgroundColor
    }
}
