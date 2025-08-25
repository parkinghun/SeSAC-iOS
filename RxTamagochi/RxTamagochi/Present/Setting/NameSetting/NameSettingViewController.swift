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
    
    var viewModel: NameSettingViewModel!
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder, viewModel: NameSettingViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    private func configureUI() {
        saveBarButtonItem.title = "저장"
        nameTextField.borderStyle = .none
    }
    
    private func bind() {
        let input = NameSettingViewModel.Input(
            saveButtonTapped: saveBarButtonItem.rx.tap,
            changeName: nameTextField.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.currentName
            .drive(nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.placeholder
            .bind(to: nameTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.validResult
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.blue : UIColor.red }
            .drive(validLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        output.validResult
            .asDriver(onErrorJustReturn: false)
            .drive(saveBarButtonItem.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.validText
            .asDriver(onErrorJustReturn: "")
            .drive(validLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.toast
            .drive(with: self) { owner, value in
                owner.navigationController?.showToastMessage(value)
            }
            .disposed(by: disposeBag)
    }    
}
