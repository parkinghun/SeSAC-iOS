//
//  MBTIViewController.swift
//  MVVMBasic
//
//  Created by 박성훈 on 8/9/25.
//

import UIKit
import SnapKit

final class MBTIViewController: UIViewController {
    let profileImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.borderWidth = 6
        view.layer.borderColor = Colors.btEnabledColor.cgColor
        return view
    }()
    let photoImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "camera.circle.fill")
        view.tintColor = Colors.btEnabledColor
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
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
        label.text = "123"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let mbtiLabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let energyView = MBTIPairView(type: MBTIViewModel.EnergyType.self)
    let perceptionView = MBTIPairView(type: MBTIViewModel.PerceptionType.self)
    let judgmentView = MBTIPairView(type: MBTIViewModel.JudgmentType.self)
    let lifestyleView = MBTIPairView(type: MBTIViewModel.LifestyleType.self)
    
    lazy var hStackView = {
        let sv = UIStackView(arrangedSubviews: [energyView, perceptionView, judgmentView, lifestyleView])
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()

    let completeButton = {
        let bt = UIButton()
        bt.setTitle("완료", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = Colors.btDisabledColor
        bt.isEnabled = false
        bt.clipsToBounds = true
        return bt
    }()
    
    private let viewModel = MBTIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgation()
        configureHierarchy()
        configureLayout()
        setupClosure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.configureUI()
        }
    }
    
    private func setupNavgation() {
        navigationItem.title = "PROFILE SETTING"
        // BackButton
    }
    
    private func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(photoImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(textFieldBorderView)
        view.addSubview(stateLabel)
        view.addSubview(mbtiLabel)
        view.addSubview(hStackView)
        view.addSubview(completeButton)
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(100)
        }
        photoImageView.snp.makeConstraints { make in
            make.center.equalTo(profileImageView).offset(35)
            make.size.equalTo(40)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
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
        hStackView.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel)
//            make.leading.equalTo(mbtiLabel.snp.trailing).offset(20)
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
    
    private func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        photoImageView.layer.cornerRadius = photoImageView.bounds.width / 2
        completeButton.layer.cornerRadius = completeButton.bounds.height / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupClosure() {
        
    }
}
