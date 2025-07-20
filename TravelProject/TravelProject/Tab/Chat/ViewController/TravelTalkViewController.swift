//
//  TravelTalkViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/19/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var emptyAnnounceLabel: UILabel!
    
    static let id = String(describing: TravelTalkViewController.self)

    private let chatRoomList = ChatList.list
    private var filteredChatRoomList: [ChatRoom] = [] {
        didSet {
            if filteredChatRoomList.isEmpty {
                collectionView.isHidden = true
                emptyAnnounceLabel.isHidden = false
            } else {
                collectionView.isHidden = false
                emptyAnnounceLabel.isHidden = true
            }
            collectionView.reloadData()
        }
    }
    
    private let navigationTitle = "TRAVEL TALK"
    private let placeholder = "친구 이름을 검색해보세요"
    private let emptyAnnounceMessage = "검색한 결과가 업습니다."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupCollectionView()
        setupSearchBar()
        configure()
        setupData()
    }
    
    private func setupNavigation() {
        navigationItem.setupWithBackButton(title: navigationTitle)
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: TravelTalkCollectionViewCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TravelTalkCollectionViewCell.id)
        
        setCollectionViewLayout()
    }
    
    private func setCollectionViewLayout() {
        let config = ChatItemLayoutConfig()
        
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = config.scrollDirection
            layout.minimumInteritemSpacing = config.itemSpacing
            layout.minimumLineSpacing = config.lineSpacing
            layout.sectionInset = config.sectionInset
            layout.itemSize = config.itemSize

            return layout
        }()
        
        collectionView.collectionViewLayout = layout
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = placeholder
        searchBar.backgroundImage = UIImage()
    }
    
    private func setupData() {
        filteredChatRoomList = chatRoomList
    }
    
    private func configure() {
        separatorView.backgroundColor = .lightGray
        emptyAnnounceLabel.configure(text: emptyAnnounceMessage, font: .boldSystemFont(ofSize: 20))
    }
}

//MARK: - SearchBarDelegate
extension TravelTalkViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchChatRoom(keyword: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchChatRoom(keyword: searchBar.text)
        searchBar.resignFirstResponder()
    }
    
    // 왜 안되냐?
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        filteredChatRoomList = chatRoomList
        searchBar.resignFirstResponder()
    }
    
    private func searchChatRoom(keyword: String?) {
        guard let keyword else { return }
        let key = keyword.lowercased().trimmingCharacters(in: .whitespaces)

        if keyword.isEmpty {
            filteredChatRoomList = chatRoomList
        } else {
            filteredChatRoomList = chatRoomList.filter { chatRoom in
                chatRoom.chatroomName.lowercased().contains(key) ||
                chatRoom.chatList.contains{ $0.user.name.lowercased().contains(key) }
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension TravelTalkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredChatRoomList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.id, for: indexPath) as? TravelTalkCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(item: filteredChatRoomList[indexPath.item])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension TravelTalkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: ChatViewController.id) as? ChatViewController else { return }
        vc.chatRoom = filteredChatRoomList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TravelTalkViewController+Extension
extension TravelTalkViewController {
    
    struct ChatItemLayoutConfig {
        let scrollDirection: UICollectionView.ScrollDirection = .vertical
        let numberOfColumns = 1
        let sectionSpacing: CGFloat = 16
        let itemSpacing: CGFloat = .zero
        let lineSpacing: CGFloat = 20
        let itemHeight: CGFloat = 60
        
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
