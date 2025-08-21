//
//  SimpleValidationViewController.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleValidationViewController: UIViewController {
    
    private let containerView = UIView()
    private let usernameLabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    private let usernameOutlet = RoundTextField(text: "")
    private let usernameValidOutlet = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    private let passwordLabel = {
        let label = UILabel()
        label.text = "Password"
        return label
    }()
    private var passwordOutlet =  RoundTextField(text: "")
    private let passwordValidOutlet = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    private let doSomethingOutlet = {
        let bt = UIButton()
        bt.setTitle("Do Something", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.font = .systemFont(ofSize: 18)
        bt.backgroundColor = .green
        return bt
    }()
    
    private let viewModel = SimpleValidationViewModel()
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        bind()
    }
    
    private func bind() {
        // driver는 vc에서만 쓰는건지(main에서 사용하니까)
        let input = SimpleValidationViewModel.Input(
            usernameText: usernameOutlet.rx.text.orEmpty,
            passwordText: passwordOutlet.rx.text.orEmpty,
            buttonTap: doSomethingOutlet.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.usernameValidText
            .bind(to: usernameValidOutlet.rx.text)
            .disposed(by: disposeBag)
        
        output.passwordValidText
            .bind(to: passwordValidOutlet.rx.text)
            .disposed(by: disposeBag)
        
        output.usernameValid
            .bind(with: self) { owner, valid in
                owner.passwordOutlet.isEnabled = valid
                owner.usernameValidOutlet.isHidden = valid
            }
            .disposed(by: disposeBag)
        
        output.passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.showAlert
            .bind(with: self) { owner, valid in
                owner.presentAlert("This is wonderful")
            }
            .disposed(by: disposeBag)
    }
}

private extension SimpleValidationViewController {
    func configureHierachy() {
        view.addSubview(containerView)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(usernameOutlet)
        containerView.addSubview(usernameValidOutlet)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(passwordOutlet)
        containerView.addSubview(passwordValidOutlet)
        containerView.addSubview(doSomethingOutlet)
    }
    
    func configureLayout() {
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(26)
            make.horizontalEdges.equalToSuperview()
        }
        usernameOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        usernameValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameOutlet.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameValidOutlet.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        passwordOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        passwordValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordOutlet.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        doSomethingOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordValidOutlet.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
