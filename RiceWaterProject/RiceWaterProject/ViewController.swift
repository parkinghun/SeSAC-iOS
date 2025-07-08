//
//  ViewController.swift
//  RiceWaterProject
//
//  Created by 박성훈 on 7/7/25.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    
    var riceCount = 0
    var waterCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        resultLabel.text = "밥알 \(riceCount)개, 물방울 \(waterCount)개"
        resultLabel.textAlignment = .center
        
        setButton(riceButton, title: "밥먹기", image: UIImage(systemName: "drop.circle"))
        setButton(waterButton, title: "물먹기", image: UIImage(systemName: "leaf.circle"))
        
        riceTextField.placeholder = "밥주세용"
        waterTextField.placeholder = "물주세용"
    }
    
    private func setButton(_ button: UIButton, title: String, image: UIImage?) {
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.clipsToBounds = true
        button.tintColor = .blue
        button.configuration?.imagePadding = 8
    }
    
    @IBAction func riceButtonTapped(_ sender: UIButton) {
        addSomething(text: riceTextField.text ?? "")
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        addSomething(isRice: false, text: waterTextField.text ?? "")
    }
    
    // 분기를 뭘로 할지 정하기
    private func addSomething(isRice: Bool = true, text: String) {
        // 1. 밥 / 물 분기하기
        // 2. text 없으면 +1
        // 3. 허용범위 - rice 0...99 / water 0...49
        // 4. 범위 안에서 숫자만큼 더해주기
        
        if !text.isEmpty {
            if isRice {
                riceCount += 1
                updateResultLabel()
            } else {
                waterCount += 1
                updateResultLabel()
            }
            return
        }
        
        guard let count = Int(text) else {
            //TODO: - 숫자 입력해줘 알럿
            showAlert()
            return
        }
        
        if isRice {
            if (0...99).contains(count) {
                riceCount += count
                updateResultLabel()
            }
        } else {
            if (0...49).contains(count) {
                waterCount += count
                updateResultLabel()
            }
        }
        
    }
    
    private func updateResultLabel() {
        resultLabel.text = "밥알 \(riceCount)개, 물방울 \(waterCount)개"
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "에러!", message: "숫자를 입력해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

