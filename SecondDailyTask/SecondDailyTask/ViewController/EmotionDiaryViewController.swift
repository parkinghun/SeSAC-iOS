//
//  EmotionDiaryViewController.swift
//  SecondDailyTask
//
//  Created by 박성훈 on 7/1/25.
//

import UIKit

class EmotionDiaryViewController: UIViewController {
    
    private var emojiLabelText: [Int] = Array(repeating: 0, count: 9)
    lazy var emojiLabels: [UILabel] = [emojiCountLabel1, emojiCountLabel2, emojiCountLabel3, emojiCountLabel4, emojiCountLabel5, emojiCountLabel6, emojiCountLabel7, emojiCountLabel8, emojiCountLabel9]
    
    @IBOutlet var emojiCountLabel1: UILabel!
    @IBOutlet var emojiCountLabel2: UILabel!
    @IBOutlet var emojiCountLabel3: UILabel!
    @IBOutlet var emojiCountLabel4: UILabel!
    @IBOutlet var emojiCountLabel5: UILabel!
    @IBOutlet var emojiCountLabel6: UILabel!
    @IBOutlet var emojiCountLabel7: UILabel!
    @IBOutlet var emojiCountLabel8: UILabel!
    @IBOutlet var emojiCountLabel9: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.view.backgroundColor = UIColor(red: 199/255, green: 177/255, blue: 153/255, alpha: 1)
    }
    
    @IBAction func emojiButtonTapped(_ sender: UIButton) {
        print("\(sender.tag) Tapped")
        emojiLabelText[sender.tag] += 1
        emojiLabels[sender.tag].text = "\(emojiLabelText[sender.tag])"
    }
}
