//
//  ViewController.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/8/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var message = ["대장님, 밥주세요", "좋은 하루에요, 고래밥님", "밥과 물을 잘먹었더니 레벨업 했어요 고마워요 대장님"]
    
    @IBOutlet var messageView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var characterNameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var waterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setUI()
    }
    
    func setNavigationItem() {
        self.navigationItem.title = "대장님의 다마고치"
        let navRightItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(presentSettingView))
        navigationItem.rightBarButtonItem = navRightItem
        
    }
    
    
    private func setUI() {
        messageView.backgroundColor = .clear
        
        messageLabel.text = "복습 아직 안하셨다구요? 지금 잠이 오세여? 대장님???"
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        characterNameLabel.text = "방실방실 다마고치"
        characterNameLabel.layer.borderColor = UIColor.blue.cgColor
        characterNameLabel.layer.borderWidth = 1
        characterNameLabel.layer.cornerRadius = 8
        characterNameLabel.clipsToBounds = true
        
        statusLabel.text = "LV4. 밥알 73개, 물방울 57개"
        
        setTextField(riceTextField, placeholder: "밥주세용")
        setTextField(waterTextField, placeholder: "물주세용")
        setButton(riceButton, title: "밥먹기", image: UIImage(systemName: "drop.circle"))
        setButton(waterButton, title: "물먹기", image: UIImage(systemName: "leaf.circle"))
    }
    
    private func setTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.textAlignment = .center
    }
    
    private func setButton(_ button: UIButton, title: String, image: UIImage?) {
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.configuration?.imagePadding = 6
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
    }
    
    
    @objc func presentSettingView() {
        print(#function)
    }
    
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {
        print(#function)
    }
}

