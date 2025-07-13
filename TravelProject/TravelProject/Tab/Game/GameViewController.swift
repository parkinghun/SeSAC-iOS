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
        print(#function)
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
    
    // TODO: - 리팩토링하기
    @IBAction func numberTextFieldDidEndOnExit(_ sender: UITextField) {
        print(#function)
        
        guard let inputText = numberTextField.text,
              let inputNumber = Int(inputText) else {
            showAlert(message: "숫자를 입력해주세요.")
            return
        }
        
        guard inputNumber > 0 else {
            showAlert(message: "0보다 큰 숫자를 입력해주세요.")
            return
        }
        
        for number in 1...inputNumber {
            results.append("\(number)")
            print(number)
        }
        
        isValid()
        print(results)
        resultTextView.text = results.joined(separator: ", ")
        resultLabel.text = "숫자\(numberTextField.text ?? "")까지 총 박수는 \(count)번 입니다."
    }
    
    //TODO: - 리팩토링하기
    private func isValid() {
        for ind in results.indices {
            var tempNumber: String = ""
            for index in results[ind].indices {
                var temp = results[ind][index]
                if temp == "3" || temp == "6" || temp == "9" {
                    temp = "👏"
                    count += 1
                }
                tempNumber.append(temp)
            }
            results[ind] = tempNumber
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
