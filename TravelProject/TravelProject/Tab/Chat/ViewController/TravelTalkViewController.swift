//
//  TravelTalkViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/19/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    static let id = String(describing: TravelTalkViewController.self)

    let chatRoomList = ChatList.list
    let navigationTitle = "TRAVEL TALK"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupCollectionView()
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
}

extension TravelTalkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatRoomList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.id, for: indexPath) as? TravelTalkCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(item: chatRoomList[indexPath.item])
        
        return cell
    }
}

extension TravelTalkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(#function, indexPath.item + 1)
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: ChatViewController.id) as? ChatViewController else { return }
        vc.chatRoom = chatRoomList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}


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
