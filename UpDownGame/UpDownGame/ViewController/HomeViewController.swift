//
//  ViewController.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/21/25.
//

import UIKit

// TODO: - 숫자가 아닐 때는 알럿 띄우기
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
        startButton.configure(title: "시작하기")
        
        inputTextField.font = DS.Font.title3
        inputTextField.placeholder = placeholder
        inputTextField.textAlignment = .center
        inputTextField.borderStyle = .none
        inputTextField.keyboardType = .numberPad
    }
    
    private func setupStartButtonAction() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        print(#function)
        let sb = UIStoryboard(name: "Game", bundle: nil)
        // 이 때 인스턴스 생성이라서 그런지?
        guard let vc = sb.instantiateViewController(withIdentifier: GameViewController.id) as? GameViewController else { return }
        
        if let text = inputTextField.text,
           let inputNumber = Int(text) {
            let randomNumber = Int.random(in: 1...inputNumber)
            vc.game = Game(inputNumber: inputNumber, randomNumber: randomNumber)
            print(randomNumber)
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func inputTextFieldDidEndOnExit(_ sender: UITextField) {
        print(#function)
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        inputTextField.resignFirstResponder()
    }
}

