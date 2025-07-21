//
//  ViewController.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var gameLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var startButton: UIButton!
    
    typealias DS = DesignSystem
    private let placeholder = "숫자를 입력해주세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupStartButtonAction()
    }
    
    private func configure() {
        configureView()
        configureUI()
    }
    
    private func configureView() {
        view.backgroundColor = DS.Color.bgColor
    }
    
    private func configureUI() {
        titleLabel.configure(text: "UP DOWN", font: DS.Font.mainTitle, alignment: .center)
        gameLabel.text = "GAME"
        logoImageView.image = DS.Image.image1
        logoImageView.contentMode = .scaleAspectFit
        inputTextField.font = DS.Font.title3
        inputTextField.placeholder = placeholder
        inputTextField.textAlignment = .center
        inputTextField.borderStyle = .none
        startButton.configure(title: "시작하기")
    }
    
    private func setupStartButtonAction() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        print(#function)
    }
    
    
    @IBAction func inputTextFieldDidEndOnExit(_ sender: UITextField) {
        print(#function)
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        inputTextField.resignFirstResponder()
    }
}

