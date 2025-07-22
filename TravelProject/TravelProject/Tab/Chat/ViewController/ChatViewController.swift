//
//  ChatViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/20/25.
//

import UIKit

// TODO: - SELF-SIZE CELL
// TODO: - dialogTextView Dynamic height
final class ChatViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var dialogTextFieldBgView: UIView!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var dialogTextView: UITextView!
    @IBOutlet var placeholderLabel: UILabel!
    
    typealias ID = ChatCommon.Id

    private let placeholder = "메세지를 입력하세요"
    private var chatItems: [ChatItem] = [] {
        didSet {
            updateUI()
        }
    }
    
    var chatRoom: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupCollectionView()
        configure()
        setupData()
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard let chatRoom else { return }
        
        let chat = Chat.makeNewChat(message: dialogTextView.text)
        ChatList.appendChat(chat, roomId: chatRoom.chatroomId)
        
        guard let roomIndex = ChatList.list.firstIndex(where: { $0.chatroomId == chatRoom.chatroomId }) else { return }
        makeChatItems(from: ChatList.list[roomIndex].chatList)
        dialogTextView.text = ""
        dialogTextView.resignFirstResponder()
    }
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        dialogTextView.resignFirstResponder()
    }
        
    private func setScrollLastItem() {
        let lastItem = chatItems.count - 1
        let lastItemIndexPath = IndexPath(item: lastItem, section: 0)
        
        collectionView.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: false)
    }
    
    private func updateUI() {
        collectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.setScrollLastItem()
        }
    }
}

// MARK: - ConfigureViewControllerProtocol
extension ChatViewController: ConfigureViewControllerProtocol {
    func setupNavigation() {
        navigationItem.setupWithBackButton(title: chatRoom?.chatroomName ?? "")
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let otherChatNib = UINib(nibName: ID.ohtersChatCell.rawValue, bundle: nil)
        let myChatNib = UINib(nibName: ID.myChatCell.rawValue, bundle: nil)
        let dividerNib = UINib(nibName: ID.dateDividerCell.rawValue, bundle: nil)
        
        collectionView.register(otherChatNib, forCellWithReuseIdentifier: ID.ohtersChatCell.rawValue)
        collectionView.register(myChatNib, forCellWithReuseIdentifier: ID.myChatCell.rawValue)
        collectionView.register(dividerNib, forCellWithReuseIdentifier: ID.dateDividerCell.rawValue)
        
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
            
            return layout
        }()
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    func configure() {
        dialogTextFieldBgView.configure(cornerRadius: 12, bgColor: .systemGray6)
        placeholderLabel.configure(text: placeholder, color: .secondaryLabel, numberOfLines: 0)
        sendButton.configure(image: UIImage(systemName: "paperplane"), color: .gray, bgColor: .clear)
        
        dialogTextView.borderStyle = .none
        dialogTextView.backgroundColor = .clear
        dialogTextView.delegate = self
    }
    
    func setupData() {
        makeChatItems(from: chatRoom?.chatList)
    }
}

// MARK: - UICollectionViewDataSource
extension ChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let emptyCell = UICollectionViewCell()
        
        switch chatItems[indexPath.item] {
        case .date(let dateString):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID.dateDividerCell.rawValue, for: indexPath) as? DateDividerCollectionViewCell else { return emptyCell }
            
            cell.configure(date: dateString)
            return cell
        case .myChat(let chat):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID.myChatCell.rawValue, for: indexPath) as? MyChatCollectionViewCell else { return emptyCell }
            
            cell.configure(item: chat)
            return cell
            
        case .otherChat(let chat):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID.ohtersChatCell.rawValue, for: indexPath) as? OhtersChatCollectionViewCell else { return emptyCell }
            
            cell.configure(item: chat)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let config = ChatItemLayoutConfig()
        switch chatItems[indexPath.item] {
        case .date:
            return CGSize(width: 180, height: 30)
        default:
            return config.itemSize
        }
    }
}

// MARK: - UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
            sendButton.isEnabled = false
        } else {
            placeholderLabel.isHidden = true
            sendButton.isEnabled = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
    }
}

// 조건에 맞게 뷰를 새로 그리던지(addSubview), 다른 셀 더 그려서 대체하던지.
// MARK: - ChatViewController+Extnension
extension ChatViewController {
    enum ChatItem {
        case date(String)
        case myChat(Chat)
        case otherChat(Chat)
    }
    
    func makeChatItems(from chats: [Chat]?) {
        var tempChatItems: [ChatItem] = []
        var lastDate: String?
        
        guard let chats else { return }
        
        for chat in chats {
            if lastDate == nil || !chat.date.isSameDay(as: lastDate!) {
                tempChatItems.append(.date(chat.date))
                lastDate = chat.date
            }
            
            if chat.user == ChatList.me {
                tempChatItems.append(.myChat(chat))
            } else {
                tempChatItems.append(.otherChat(chat))
            }
        }
        
        self.chatItems = tempChatItems
    }
    
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
