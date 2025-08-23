//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/8/25.
//

import UIKit
import RxSwift
import RxCocoa

final class NameSettingViewController: UIViewController, ConfigureViewControllerProtocol {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var validLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    
    private let viewModel = NameSettingViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupNavigation()
        bind()
    }
    
    private func setUI() {
        //        nameTextField.text = tamagochi.name
        nameTextField.borderStyle = .none
    }
    
    private func setupNavigation() {
        //        saveBarButtonItem.title = "대장님 이름 정하기"
    }
    
    private func bind() {
        let input = NameSettingViewModel.Input(
            saveButtonTapped: saveBarButtonItem.rx.tap,
            changeName: nameTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.placeholder
            .bind(to: nameTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func saveBarButtonItemTapped(_ sender: UIBarButtonItem) {
        print(#function)
        
        //        guard let name = nameTextField.text else { return }
        
        //        if isValid(name: name) {
        //            tamagochi.name = name
        //            saveNameToUserDefault()
        //            self.navigationController?.popViewController(animated: true)
        //        }
        //    }
        
        //    private func isValid(name: String) -> Bool {
        //        guard tamagochi.name != (nameTextField.text ?? "") else {
        //            showAlert(message: "동일한 이름으로 변경이 불가능합니다.")
        //            return false
        //        }
        //        guard name.count >= 2, name.count <= 6 else {
        //            showAlert(message: "이름은 2글자 이상 6글자 이하로 작성해주세요.")
        //            return false
        //        }
        //        guard !name.contains(" ") else {
        //            showAlert(message: "이름에 띄어쓰기는 불가능합니다.")
        //            return false
        //        }
        //        return true
        //    }
        
        //    private func saveNameToUserDefault() {
        //        TamagochiManager.shared.save()
        //    }
        
        //    private func showAlert(message: String) {
        //        let alert = UIAlertController(title: "대장 이름 에러", message: message, preferredStyle: .alert)
        //        let ok = UIAlertAction(title: "OK", style: .default)
        //        alert.addAction(ok)
        //        present(alert, animated: true)
        //    }
        
        //    @IBAction func nameTextFieldDidEndOnExit(_ sender: UITextField) {
        //        print(#function)
        //    }
        
        //    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        //        self.view.endEditing(true)
        //    }
    }
}
