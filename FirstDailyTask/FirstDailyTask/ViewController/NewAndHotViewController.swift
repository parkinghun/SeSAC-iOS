//
//  NewAndHotViewController.swift
//  FirstDailyTask
//
//  Created by 박성훈 on 7/2/25.
//

import UIKit

class NewAndHotViewController: UIViewController {

    @IBOutlet var textFieldStackView: UIStackView!
    @IBOutlet var choiceButtons: [UIButton]!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var buttonTag = 0
    let buttonsItem: [Int: (image: UIImage, title: String)] = [0: (image: UIImage.blue, title: "공개 예정"),
                                                 1: (image: UIImage.turquoise, title: "모두의 인기 콘텐츠"),
                                                 2: (image: UIImage.pink, title: "TOP 10 시리즈")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        resultLabel.text = (buttonsItem[buttonTag] ?? (UIImage.blue, "")).title
        textFieldStackView.layer.cornerRadius = 8
        textFieldStackView.clipsToBounds = true
        
        setButtons()
    }
    
    private func setButtons() {
        choiceButtons.forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.configuration?.cornerStyle = .capsule
            $0.layer.cornerRadius = $0.bounds.height / 2
            $0.layer.masksToBounds = true
            $0.tag = buttonTag
            designButton($0)
            buttonTag += 1
            print(#function)
        }
    }
    
    private func designButton(_ bt: UIButton) {
        let firstBT = bt.tag == 0
        
        let item = buttonsItem[bt.tag] ?? (UIImage.blue, "")
        bt.setTitle(item.title, for: .normal)
        bt.setImage(item.image, for: .normal)
        bt.setTitleColor(firstBT ? .black : .lightGray, for: .normal)
        bt.backgroundColor = firstBT ? .white : .clear
        // Deprecated
        bt.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    
    @IBAction func choiceButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        let text = (buttonsItem[sender.tag] ?? (UIImage.blue, "")).title
        resultLabel.text = "\(text) 작품이 없습니다."
        setButtonColor(tag: sender.tag)
    }
    
    private func setButtonColor(tag: Int) {
        for button in choiceButtons {
            if button.tag == tag {
                button.backgroundColor = .white
                button.setTitleColor(.black, for: .normal)
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(.lightGray, for: .normal)
            }
        }
    }
}
