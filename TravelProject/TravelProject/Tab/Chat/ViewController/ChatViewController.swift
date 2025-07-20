//
//  ChatViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/20/25.
//

import UIKit

final class ChatViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var dialogTextFieldBgView: UIView!
    @IBOutlet var dialogTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    static let id = String(describing: ChatViewController.self)
    private let placeholder = "메세지를 입력하세요"
    
    var chatRoom: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupCollectoinView()
        configure()
    }
    
    private func setupNavigation() {
        navigationItem.setupWithBackButton(title: chatRoom?.chatroomName ?? "")
    }
    
    private func setupCollectoinView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let otherChatNib = UINib(nibName: OhtersChatCollectionViewCell.id, bundle: nil)
        let myChatNib = UINib(nibName: MyChatCollectionViewCell.id, bundle: nil)
        collectionView.register(otherChatNib, forCellWithReuseIdentifier: OhtersChatCollectionViewCell.id)
        collectionView.register(myChatNib, forCellWithReuseIdentifier: MyChatCollectionViewCell.id)
        
        configureCollectionViewLayout()
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.setScrollLastItem()
        }
    }
    
    private func configureCollectionViewLayout() {
        let config = ChatItemLayoutConfig()
        
        let flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = config.scrollDirection
            layout.minimumInteritemSpacing = config.itemSpacing
            layout.minimumLineSpacing = config.lineSpacing
            layout.sectionInset = config.sectionInset
            layout.itemSize = config.itemSize

            return layout
        }()
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    // viewDidLoad에서 동작을 안함.
    private func setScrollLastItem() {
        guard let chatRoom else { return }
        let lastItem = chatRoom.chatList.count - 1
        let lastItemIndexPath = IndexPath(item: lastItem, section: 0)
        
        collectionView.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: false)
    }
    
    private func configure() {
        dialogTextFieldBgView.configure(cornerRadius: 12, bgColor: .systemGray6)
        dialogTextField.placeholder = placeholder
        dialogTextField.borderStyle = .none
        sendButton.configure(image: UIImage(systemName: "paperplane"), color: .gray, bgColor: .clear)
    }
}

extension ChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatRoom?.chatList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let emptyCell = UICollectionViewCell()
        guard let chatRoom else { return emptyCell }
        let chat = chatRoom.chatList[indexPath.item]
        
        if chat.user == ChatList.me {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyChatCollectionViewCell.id, for: indexPath) as? MyChatCollectionViewCell else { return emptyCell }
            
            cell.configure(item: chat)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OhtersChatCollectionViewCell.id, for: indexPath) as? OhtersChatCollectionViewCell else { return emptyCell }
            
            cell.configure(item: chat)
            return cell
        }
    }
}

extension ChatViewController: UICollectionViewDelegate {
    
}

extension ChatViewController {
    struct ChatItemLayoutConfig {
        let scrollDirection: UICollectionView.ScrollDirection = .vertical
        let numberOfColumns = 1
        let sectionSpacing: CGFloat = 16
        let itemSpacing: CGFloat = .zero
        let lineSpacing: CGFloat = 20
        let itemHeight: CGFloat = 120
        
        var itemWidth: CGFloat {
            let totalWidth = UIScreen.main.bounds.width
            let totalSpacing = sectionSpacing * 2 + itemSpacing * CGFloat(numberOfColumns - 1)
            return totalWidth - totalSpacing
        }
        
        var sectionInset: UIEdgeInsets {
            return UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        }
        
        var itemSize: CGSize {
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
}
