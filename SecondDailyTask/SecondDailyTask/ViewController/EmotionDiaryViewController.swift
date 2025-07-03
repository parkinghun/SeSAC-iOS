//
//  EmotionDiaryViewController.swift
//  SecondDailyTask
//
//  Created by 박성훈 on 7/1/25.
//

import UIKit

class EmotionDiaryViewController: UIViewController {

    var items: [Int: (emotion: String, emoji: UIImage?, count: Int)] = [
        0: ("행복해", UIImage.mono_slime1, 0),
        1: ("사랑해", UIImage.mono_slime2, 0),
        2: ("좋아해", UIImage.mono_slime3, 0),
        3: ("당황해", UIImage.mono_slime4, 0),
        4: ("속상해", UIImage.mono_slime5, 0),
        5: ("우울해", UIImage.mono_slime6, 0),
        6: ("심심해", UIImage.mono_slime7, 0),
        7: ("싫어해", UIImage.mono_slime8, 0),
        8: ("슬퍼해", UIImage.mono_slime9, 0),
    ]
    
    @IBOutlet var emojiButtons: [UIButton]!
    @IBOutlet var emojiLabels: [UILabel]!
    @IBOutlet var stackViews: [UIStackView]!
    @IBOutlet var buttonOuterView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.view.backgroundColor = UIColor(red: 199/255, green: 177/255, blue: 153/255, alpha: 1)
        
        stackViews.forEach {
            $0.spacing = 12
            $0.distribution = .fillEqually
            $0.alignment = .center
            $0.backgroundColor = .clear
        }
        
        for index in emojiButtons.indices {
            emojiButtons[index].setImage(items[index]?.emoji, for: .normal)
            emojiButtons[index].imageView?.contentMode = .scaleAspectFit
            emojiButtons[index].tag = index
            
            emojiLabels[index].text = "\(items[index]!.emotion) \(items[index]!.count)"
            emojiLabels[index].textAlignment = .center
            
            buttonOuterView[index].backgroundColor = .clear
        }
    }
    
    // 옵셔널 바인딩
    @IBAction func emojiButtonTapped(_ sender: UIButton) {
        print("\(sender.tag) Tapped")
        items[sender.tag]!.count += 1

        let item = items[sender.tag]
        emojiLabels[sender.tag].text = "\(item!.emotion) \(item!.count)"
    }
    
}
