//
//  ShoppingTableViewController.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/10/25.
//

import UIKit

enum SectionType {
    case purchased
    case unPurchased
    
    var title: String {
        switch self {
        case .purchased:
            return "구매 완료"
        case .unPurchased:
            return "구매 예정"
        }
    }
}

final class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    private var shoppingList: [ShoppingData] = [ShoppingData(todo: "그립톡 구매하기"),
                                                ShoppingData(todo: "사이다 구매"),
                                                ShoppingData(todo: "아이패드 케이스 최저가 알아보기"),
                                                ShoppingData(todo: "양말")]
    
    private var sections: [SectionType] {
        var result = [SectionType]()
        
        if !unPurchasedList.isEmpty { result.append(.unPurchased) }
        if !purchasedList.isEmpty { result.append(.purchased) }
        
        return result
    }
    
    private var purchasedList: [ShoppingData] {
        return shoppingList.filter { $0.isPurchased }
    }
    
    private var unPurchasedList: [ShoppingData] {
        return shoppingList.filter { !$0.isPurchased }
    }
    
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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .unPurchased:
            return unPurchasedList.count
        case .purchased:
            return purchasedList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.id, for: indexPath) as? ShoppingTableViewCell else {
            return UITableViewCell()
        }
        
        let tempShoppingData: ShoppingData
        
        switch sections[indexPath.section] {
        case .unPurchased:
            tempShoppingData = unPurchasedList[indexPath.row]
        case .purchased:
            tempShoppingData = purchasedList[indexPath.row]
        }
        
        cell.checkButton.setImage(tempShoppingData.pushasedImage, for: .normal)
        cell.todoabel.text = tempShoppingData.todo
        cell.favoriteButton.setImage(tempShoppingData.favoriteImage, for: .normal)
        
        cell.checkButtonAction = { [weak self] in
            guard let self else { return }
            self.checkButtonClicked(at: indexPath)
        }
        
        cell.favoriteButtonAction = { [weak self] in
            guard let self else { return }
            self.favoriteButtonClicked(at: indexPath)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = getItem(indexPath: indexPath)
        print(#function, indexPath, item)
        let removeItem = getItem(indexPath: indexPath)
        if let index = shoppingList.firstIndex(where: { $0.id == removeItem.id }) {
            shoppingList.remove(at: index)
            tableView.reloadData()
        }
    }
    
    private func getItem(indexPath: IndexPath) -> ShoppingData {
        switch sections[indexPath.section] {
        case .unPurchased:
            return unPurchasedList[indexPath.row]
        case .purchased:
            return purchasedList[indexPath.row]
        }
    }
    
    // 스와이프를 통한 삭제 기능
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { [weak self] _, _, success in
            guard let self else { return }
            let removeItem = self.getItem(indexPath: indexPath)
            if let index = self.shoppingList.firstIndex(where: { $0.id == removeItem.id }) {
                self.shoppingList.remove(at: index)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete])
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
        
        let item = ShoppingData(todo: text, isPurchased: false, isFavorite: false)
        shoppingList.append(item)
    }
    
    func checkButtonClicked(at indexPath: IndexPath) {
        print(#function)
        let item = getItem(indexPath: indexPath)
        if let index = shoppingList.firstIndex(where: { $0.id == item.id }) {
            shoppingList[index].isPurchased.toggle()
            tableView.reloadData()
        }
    }
    
    func favoriteButtonClicked(at indexPath: IndexPath) {
        print(#function)

        let item = getItem(indexPath: indexPath)
        if let index = shoppingList.firstIndex(where: { $0.id == item.id }) {
            shoppingList[index].isFavorite.toggle()
            tableView.reloadData()
        }
    }
}
