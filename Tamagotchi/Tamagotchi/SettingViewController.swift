//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/8/25.
//

import UIKit

class SettingViewController: UIViewController {

    let tamagochi = TamagochiManager.shared.tamagochi

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationItem()
    }
    
    private func setUI() {
        nameTextField.text = tamagochi.name
        nameTextField.placeholder = "이름을 입력해주세요."
        nameTextField.borderStyle = .none
    }

    func setNavigationItem() {
        self.navigationItem.title = "대장님 이름 정하기"
        saveBarButtonItem.title = "저장"
    }
    
    @IBAction func saveBarButtonItemTapped(_ sender: UIBarButtonItem) {
        print(#function)
        
        guard let name = nameTextField.text else { return }
        
        if isValid(name: name) {
            tamagochi.name = name
            saveNameToUserDefault()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func isValid(name: String) -> Bool {
        guard tamagochi.name != (nameTextField.text ?? "") else {
            showAlert(message: "동일한 이름으로 변경이 불가능합니다.")
            return false
        }
        guard name.count >= 2, name.count <= 6 else {
            showAlert(message: "이름은 2글자 이상 6글자 이하로 작성해주세요.")
            return false
        }
        guard !name.contains(" ") else {
            showAlert(message: "이름에 띄어쓰기는 불가능합니다.")
            return false
        }
        return true
    }
    
    private func saveNameToUserDefault() {
        TamagochiManager.shared.save()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "대장 이름 에러", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    @IBAction func nameTextFieldDidEndOnExit(_ sender: UITextField) {
        print(#function)
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
