//
//  ShoppingTableViewController.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/10/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var addButton: UIButton!

    
    
    //TODO: -
    // 1. 텍스트필드 베젤 x, placeholder - 무엇을 구매하실 건가요?
    // 2. 버튼 타이틀: 추가, 코너레디우스, 백그라운드 컬러
    // 3. 헤더뷰 코너 및 백그라운드컬러
    var list = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최조가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        headerView.backgroundColor = .systemGray4
        headerView.layer.cornerRadius = 12
        headerView.clipsToBounds = true
        
        searchTextField.placeholder = "무엇을 구매하실 건가요?"
        searchTextField.borderStyle = .none
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .systemGray2
        addButton.layer.cornerRadius = 8
        addButton.clipsToBounds = true
        
//        cellBackgroundView.backgroundColor = .lightGray
//        cellBackgroundView.layer.cornerRadius = 10
//        cellBackgroundView.clipsToBounds = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.id, for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "checkmark.square")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print(#function)
        appendShoppingItemToList()
        tableView.reloadData()
    }
    
    private func appendShoppingItemToList() {
        guard let text = searchTextField.text else { return }
        guard !text.isEmpty else {
            print("빈문자열 -")
            return
        }
        list.append(text)
    }
    
    
}
