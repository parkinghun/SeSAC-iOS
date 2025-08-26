//
//  LottoViewController.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LottoViewController: BaseViewController {
    
    private let textField = {
        let tf = UITextField()
        tf.placeholder = "회차를 입력해주세요"
        tf.borderStyle = .roundedRect
        return tf
    }()
    private let checkButton = {
        let bt = UIButton()
        bt.setTitle("조회", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.backgroundColor = .yellow
        return bt
    }()
    private let resultLabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .lightGray
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let disposeBag = DisposeBag()
    let viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        bind()
    }
    
    func bind() {
        let input = LottoViewModel.Input(
            query: textField.rx.text.orEmpty,
            checkButtonTapped: checkButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        checkButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        output.result
            .asDriver(onErrorJustReturn: "")
            .drive(resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.showToast
            .asDriver(onErrorJustReturn: .init(status: .check, message: ""))
            .drive(with: self) { owner, value in
                owner.showToastMessage(value)
            }
            .disposed(by: disposeBag)
        
        output.showAlert
            .asDriver(onErrorJustReturn: .init(title: "", message: "", ok: ""))
            .drive(with: self) { owner, value in
                owner.showAlert(alertStyle: value)
            }
            .disposed(by: disposeBag)
    }
    
    func configureHierachy() {
        let uiComponents = [textField, checkButton, resultLabel]
        uiComponents.forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        checkButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 44))
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(checkButton.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
}
