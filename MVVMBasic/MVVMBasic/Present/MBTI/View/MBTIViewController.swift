//
//  MBTIViewController.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import UIKit
import SnapKit

final class MBTIViewController: UIViewController {
    let profileView = ProfileView()
    let nicknameTextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력해주세요 :)"
        tf.borderStyle = .none
        return tf
    }()
    let textFieldBorderView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    let stateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let mbtiLabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    let mbtiView = MBTIView()
    let completeButton = {
        let bt = UIButton()
        bt.setTitle("완료", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = Colors.btDisabledColor
        bt.isEnabled = false
        bt.clipsToBounds = true
        return bt
    }()
    
    let viewModel = MBTIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgation()
        configureHierarchy()
        configureLayout()
        configureView()
        configureAction()
        bindData()
        setupClosure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.configureRadius()
        }
    }
    
    private func bindData() {
        viewModel.output.profileTapped.lazyBind { _ in
            print("이미지 눌림")
            // 네비게이션 컨트롤러로 프로필 세팅뷰 이동
        }
        viewModel.output.stateMessage.lazyBind { [weak self] value in
            guard let self else { return }
            stateLabel.text = value
        }
        viewModel.output.nicknameValidate.lazyBind { [weak self] value in
            guard let self else { return }
            stateLabel.textColor = value ? Colors.labelEnabledColor : Colors.labelDisabledColor
        }
        //TODO: - MBTI
        // mbtiView의 로직을 실행
        viewModel.output.tappedButtonIndex.lazyBind { [weak self] value in
            guard let self else { return }
            mbtiView.updateBT(index: value)
        }
        
        //TODO: - 완료버튼
    }
    
    private func setupNavgation() {
        navigationItem.title = "PROFILE SETTING"
        // BackButton
    }
    
    private func configureHierarchy() {
        view.addSubview(profileView)
        view.addSubview(nicknameTextField)
        view.addSubview(textFieldBorderView)
        view.addSubview(stateLabel)
        view.addSubview(mbtiLabel)
        view.addSubview(mbtiView)
        view.addSubview(completeButton)
    }
    
    private func configureLayout() {
        profileView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(100)
        }

        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        textFieldBorderView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(nicknameTextField)
            make.height.equalTo(1)
        }
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldBorderView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(textFieldBorderView).inset(8)
        }
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(nicknameTextField)
            make.top.equalTo(stateLabel.snp.bottom).offset(30)
        }
        mbtiView.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(44 * 4 + 12 * 3)
            make.height.equalTo(44 * 2 + 12)
        }
        completeButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
    
    
    private func configureView() {
        profileView.profileImageView.image = UIImage(named: viewModel.randomImageName)
    }
    
    private func configureRadius() {
        completeButton.layer.cornerRadius = completeButton.bounds.height / 2
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configureAction() {
        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        profileView.addGestureRecognizer(profileTapGestureRecognizer)
        
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        print(#function)
        viewModel.input.profileTapped.value = ()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        print(#function)
        viewModel.input.nicknameText.value = textField.text
    }
    
    private func setupClosure() {
        mbtiView.closure = { [weak self] index in
            guard let self else { return }
            viewModel.input.mbtiTapped.value = index
            
        }
    }
}
