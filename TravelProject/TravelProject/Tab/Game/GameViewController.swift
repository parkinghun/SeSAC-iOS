//
//  GameViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import UIKit

final class GameViewController: UIViewController {
    
    private var resultText = ""
    var results: [String] = []
    var count = 0
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var placeholderLabel: UILabel!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        configureLabel()
        configureTextField()
    }
    
    private func configureLabel() {
        placeholderLabel.text = "최대 숫자를 입력해주세요"
        placeholderLabel.textColor = .gray
        placeholderLabel.textAlignment = .center
        
        resultLabel.text = "총 몇번의 박수를 쳤을까요? "
        resultLabel.font = .boldSystemFont(ofSize: 25)
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
    }
    
    private func configureTextField() {
        resultTextView.text = "3, 6, 9 게임을 해보아요."
        resultTextView.isEditable = false
        resultTextView.font = .systemFont(ofSize: 20)
        resultTextView.textColor = .gray
        resultTextView.textAlignment = .center
    }
    
    @IBAction func numberTextFieldDidEndOnExit(_ sender: UITextField) {
        print(#function)
        
        guard let inputText = numberTextField.text,
              let inputNumber = Int(inputText) else {
            showAlert(message: "숫자를 입력해주세요.")
            return
        }
        
        guard inputNumber > 0, inputNumber < 1000 else {
            showAlert(message: "입력 가능한 숫자는 1부터 999까지 입니다.")
            return
        }
        
        for number in 1...inputNumber {
            results.append("\(number)")
            print(number)
        }
        
        replaceWithClappingEmoji()
        print(results)
        resultTextView.text = results.joined(separator: ", ")
        resultLabel.text = "숫자\(numberTextField.text ?? "")까지 총 박수는 \(count)번 입니다."
    }
    
    
    private func replaceWithClappingEmoji() {
        for index in results.indices {
            var tempNumber: String = ""
            for stringIndex in results[index].indices {
                var temp = results[index][stringIndex]
                if temp == "3" || temp == "6" || temp == "9" {
                    temp = "👏"
                    count += 1
                }
                tempNumber.append(temp)
            }
            results[index] = tempNumber
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "입력 에러", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    @IBAction func numberTextFieldEditingChanged(_ sender: UITextField) {
        print(#function)
        guard let text = numberTextField.text, !text.isEmpty else {
            placeholderLabel.isHidden = false
            return
        }
        placeholderLabel.isHidden = true
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        numberTextField.resignFirstResponder()
    }
}
