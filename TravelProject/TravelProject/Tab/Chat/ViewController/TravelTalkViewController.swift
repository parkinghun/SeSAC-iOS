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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupCollectionView()
    }
    
    private func setupNavigation() {
        navigationItem.title = "TRAVEL TALK"
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "TravelTalk", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TravelTalkCollectionViewCell.id)
    }
    
    private func setLayout() {
        
    }
}

extension TravelTalkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.id, for: indexPath) as? TravelTalkCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension TravelTalkViewController: UICollectionViewDelegate {
    
}
