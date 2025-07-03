//
//  ViewController.swift
//  NeologismFinder
//
//  Created by 박성훈 on 7/3/25.
//

import UIKit

final class ViewController: UIViewController {
    
    let neologism: [[String: String]] = [
        ["킹받네": "엄청 열받네 (킹 + 열받네)"],
        ["손민수": "특정 인물 스타일을 그대로 따라함 (드라마 캐릭터 이름에서 유래)"],
        ["스불재": "스스로 불러온 재앙 (자업자득 느낌)"],
        ["JMT": "존맛탱, 엄청 맛있다는 뜻"],
        ["당모치": "당연히 모든 치킨은 옳다"],
        ["추구미": "추구하는 미적 스타일’의 줄임말인 추구미는 개인이 지향하는 미적 감각이나 이미지를 뜻함"]
    ]
    
    @IBOutlet var searchStackView: UIStackView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var recentSearchButton: [UIButton]!
    @IBOutlet var recentSearchButtonStackView: UIStackView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        var index = 0
        searchStackView.layer.borderWidth = 2
        searchStackView.layer.borderColor = UIColor.black.cgColor
        
        searchTextField.placeholder = "신조어를 입력해주세요"
        
        searchButton.setTitle("", for: .normal)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
        
        recentSearchButtonStackView.spacing = 8
        recentSearchButton.forEach {
            $0.setTitle(neologism[index].keys.first, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.clipsToBounds = true
            $0.backgroundColor = .clear
            $0.tintColor = .black
            index += 1
        }
        
        backgroundImageView.contentMode = .scaleAspectFill
        resultLabel.text = "신조어를 입력해주세요"
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        print(#function)
        searchTextField.resignFirstResponder()
        searchText(searchTextField.text)
    }
    
    @IBAction func textFieldReturnTapped(_ sender: UITextField) {
        print(#function)
        searchText(searchTextField.text)
    }
    
    @IBAction func recentSearchButtonTapped(_ sender: UIButton) {
        print(#function)
        searchText(sender.currentTitle)
        searchTextField.text = sender.currentTitle
        updateButtonStyle(sender)
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func searchText(_ text: String?) {
        for item in neologism {
            // 대소문자 구분없이 비교하는 방법
            if (item.keys.first ?? "").caseInsensitiveCompare(text ?? "") != .orderedSame {
                resultLabel.text = "검색한 결과가 없습니다."
            } else {
                resultLabel.text = item.values.first
                break
            }
        }
    }
    
    private func updateButtonStyle(_ bt: UIButton) {
        recentSearchButton.forEach {
            $0.backgroundColor = $0 == bt ? .magenta : .white
        }
    }
}
