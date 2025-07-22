//
//  TravelTalkViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/19/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {
    
    typealias ID = ChatCommon.Id

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var emptyAnnounceLabel: UILabel!
    
    private let chatRoomList = ChatList.list
    private var filteredChatRoomList: [ChatRoom] = [] {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCollectionView()
        setupSearchBar()
        configure()
        setupData()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = TravelTalkText.placeholder.text
        searchBar.backgroundImage = UIImage()
    }
    
    private func updateUI() {
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

// MARK: - ConfigureViewControllerProtocol
extension TravelTalkViewController: ConfigureViewControllerProtocol {
    func setupNavigation() {
        navigationItem.setupWithBackButton(title: TravelTalkText.navigationTitle.text)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: ID.travelTalkCell.rawValue, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ID.travelTalkCell.rawValue)
        
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
    
    func configure() {
        separatorView.backgroundColor = .lightGray
        emptyAnnounceLabel.configure(text: TravelTalkText.emptyAnnounceMessage.text,
                                     font: .boldSystemFont(ofSize: 20))
    }
    
    func setupData() {
        filteredChatRoomList = chatRoomList
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
    
    // TODO: - 동작 확인
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID.travelTalkCell.rawValue, for: indexPath) as? TravelTalkCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(item: filteredChatRoomList[indexPath.item])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension TravelTalkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: ID.chatVC.rawValue) as? ChatViewController else { return }
        vc.chatRoom = filteredChatRoomList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TravelTalkViewController+Extension
extension TravelTalkViewController {
    
    enum TravelTalkText {
        case navigationTitle
        case placeholder
        case emptyAnnounceMessage
        
        var text: String {
            switch self {
            case .navigationTitle:
                return "TRAVEL TALK"
            case .placeholder:
                return "친구 이름을 검색해보세요"
            case .emptyAnnounceMessage:
                return "검색한 결과가 업습니다."
            }
        }
    }
    
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
