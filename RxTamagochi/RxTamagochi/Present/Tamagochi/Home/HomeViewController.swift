//
//  ViewController.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/8/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet var messageView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var characterNameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var waterButton: UIButton!
    @IBOutlet var settingButton: UIBarButtonItem!
    @IBOutlet var characterNameView: UIView!
    
    let disposeBag = DisposeBag()
    let viewModel: HomeViewModel
    
    required init?(coder: NSCoder, viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        setUI()
        bind()
    }
    
    func bind() {
        let input = HomeViewModel.Input(
            settingButtonTapped: settingButton.rx.tap,
            feedRiceTapped: riceButton.rx.tap,
            amountRice: riceTextField.rx.text.orEmpty,
            feedWaterTappd: waterButton.rx.tap,
            amountWater: waterTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.navigationTitle
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.riceValid
            .drive(riceButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.waterValid
            .drive(waterButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.tamagochi
            .drive(with: self) { owner, tamagochi in
                owner.configureUI(tamagochi: tamagochi)
            }
            .disposed(by: disposeBag)
        
        output.tamagochiTalk
            .drive(messageLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func configureUI(tamagochi: Tamagochi) {
        characterImageView.image = UIImage(named: tamagochi.image)
        characterNameLabel.text = tamagochi.type.title
        statusLabel.text = "LV\(tamagochi.level) ∙ 밥알 \(tamagochi.rice)개 ∙ 물방울 \(tamagochi.water)개"
    }
    
    
    func setNavigationItem() {
        settingButton.image = UIImage(systemName: "person.circle")
        let backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func setUI() {
        messageView.backgroundColor = .clear
        
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        characterNameView.layer.borderColor = UIColor.blue.cgColor
        characterNameView.layer.borderWidth = 1
        characterNameView.layer.cornerRadius = 8
        characterNameView.clipsToBounds = true
        
        setTextField(riceTextField, placeholder: "밥주세용")
        setTextField(waterTextField, placeholder: "물주세용")
        setButton(riceButton, title: "밥먹기", image: UIImage(systemName: "drop.circle"))
        setButton(waterButton, title: "물먹기", image: UIImage(systemName: "leaf.circle"))
    }
    
    private func setTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
    }
    
    private func setButton(_ button: UIButton, title: String, image: UIImage?) {
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.configuration?.imagePadding = 6
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {
        print(#function)
    }
}

