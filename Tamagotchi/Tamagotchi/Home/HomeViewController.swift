//
//  ViewController.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/8/25.
//

import UIKit
// TODO: - 키보드 올렸을 때 - TF 올리기
// TODO: - 프로퍼티 래퍼 사용하기
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
    
    let tamagochi = TamagochiManager.shared.tamagochi
    
    var statusDescription: String {
        return "LV\(tamagochi.level) ∙ 밥알 \(tamagochi.rice)개 ∙ 물방울 \(tamagochi.water)개"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        setUI()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        self.navigationItem.title = "\(tamagochi.name)님의 다마고치"
        statusLabel.text = statusDescription
        messageLabel.text = tamagochi.randomMessage
    }
    
    func setNavigationItem() {
        settingButton.image = UIImage(systemName: "person.circle")
        let backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func setUI() {
        messageView.backgroundColor = .clear
        
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        characterImageView.image = UIImage(named: "2-\(tamagochi.level)")
        
        characterNameLabel.text = tamagochi.type.title
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
    
    
    @objc func presentSettingView() {
        print(#function)
    }
    
    
    @IBAction func riceButtonTapped(_ sender: UIButton) {
        print(#function)
        guard let text = riceTextField.text else { return }
        eatSomething(text: text)
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        print(#function)
        guard let text = waterTextField.text else { return }
        eatSomething(isRice: false, text: text)
        
    }
    
    private func eatSomething(isRice: Bool = true, text: String) {
        let max = isRice ? 99 : 49
        guard let count = isValid(text, max: max) else { return }
        
        if isRice {
            tamagochi.rice += count
        } else {
            tamagochi.water += count
        }
        
        statusLabel.text = statusDescription
        messageLabel.text = tamagochi.randomMessage
        levelCheck()
        TamagochiManager.shared.save()
    }
    
    private func isValid(_ text: String, max: Int) -> Int? {
        guard !text.isEmpty else {
            return 1
        }
        
        guard let number = Int(text) else {
            showAlert(message: "숫자를 입력해주세요.")
            return nil
        }
        
        guard number <= max else {
            showAlert(message: "\(max)개 이하로만 입력할 수 있어요.")
            return nil
        }
        
        return number
    }
    
    private func levelCheck() {
        let level = calculateLevel(rice: tamagochi.rice, water: tamagochi.water)
        guard level != tamagochi.level else { return }
        tamagochi.level = level
        updateCharacterImage(level: level)
    }
    
    private func calculateLevel(rice: Int, water: Int) -> Int {
        let riceScore = Double(rice) / 5
        let waterScore = Double(water) / 2
        let totalScore = riceScore + waterScore
        
        var level = Int((totalScore / 10).rounded())
        if level < 1 {
            level = 1
        } else if level > 10 {
            level = 10
        }
        return level
    }
    
    private func updateCharacterImage(level: Int) {
        let imageName = level == 10 ? "2-9" : "2-\(level)"
        characterImageView.image = UIImage(named: imageName)
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "먹는거 에러", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {
        print(#function)
    }
}

