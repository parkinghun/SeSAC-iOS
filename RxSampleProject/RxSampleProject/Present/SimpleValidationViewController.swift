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

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

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
        label.text = "Username has to be at least \(minimalUsernameLength) characters"
        label.textColor = .red
        return label
    }()
    
    private let passwordLabel = {
        let label = UILabel()
        label.text = "Password"
        return label
    }()
    private let passwordOutlet =  RoundTextField(text: "")
    private let passwordValidOutlet = {
        let label = UILabel()
        label.text = "Password has to be at least \(minimalPasswordLength) characters"
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
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        bind()
    }
    
    private func bind() {
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)  // cold -> hot
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .subscribe(with: self, onNext:  { owner, _ in
                owner.presentAlert("This is wonderful")
            })
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
