//
//  GameViewController.swift
//  UpDownGame
//
//  Created by 박성훈 on 7/22/25.
//

import UIKit

final class GameViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var resultButton: UIButton!
    
    typealias DS = DesignSystem
    static let id = String(describing: GameViewController.self)
    
    // Property Wrapper를 사용하면 에러가 발생하는 이유?
    // 이 때 updateUI()에 접근해서 그런 것 같은데..
    var game: Game?
    private var countText: String {
        guard let game else { return "" }
        return "시도 횟수: \(game.count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configure()
        setupStartButtonAction()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: GameCollectionViewCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: GameCollectionViewCell.id)
        
        configureFlowLayout()
    }
    
    private func configureFlowLayout() {
        let itemSpacing = DS.Spacing.small
        let screenWidth = UIScreen.main.bounds.width
        let totalWidth = screenWidth - (itemSpacing * 2) - itemSpacing * CGFloat(CollectionViewLayout.columnsCount - 1)
        let itemWidth = totalWidth / CGFloat(CollectionViewLayout.columnsCount)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = CollectionViewLayout.scrollDirection
        flowLayout.minimumLineSpacing = itemSpacing
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.sectionInset = CollectionViewLayout.sectionInset
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func configure() {
        configureView()
        configureUI()
    }
    
    private func configureView() {
        view.backgroundColor = DS.Color.bgColor
    }
    
    private func configureUI() {
        guard let game else { return }
        titleLabel.configure(text: game.gameState.rawValue, font: DS.Font.mainTitle, alignment: .center)
        countLabel.text = countText
        
        resultButton.configure(title: "결과 확인하기", color: .white, bgColor: .gray)
        resultButton.isEnabled = false
    }
    
    private func updateUI() {
        guard let game else { return }
        titleLabel.text = game.gameState.rawValue
        countLabel.text = countText
        resultButton.isEnabled = false
        resultButton.backgroundColor = .gray
        
        collectionView.reloadData()
        
        // TODO: - 특정 아이템들만 리로드
//        let indexPath = IndexPath(item: <#T##Int#>, section: 0)
    }
    
    private func setupStartButtonAction() {
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    @objc private func resultButtonTapped() {
        // TODO: - 옵셔널 체이닝 안하고 싶음
        game?.updateGame()
        updateUI()
        bingoAction()
    }
    
    private func bingoAction() {
        if game?.gameState == .bingo {
            showAlert(title: "🎉 BINGO 🎉", message: "첫 화면으로 돌아가기") { [weak self] _ in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game else { return 0 }
        return game.numberArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.id, for: indexPath) as? GameCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let game else { return UICollectionViewCell() }
        
        cell.configure(number: game.numberArray[indexPath.item])
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // TODO: - 강제 언래핑 제거
        game!.selectedNumber = game!.numberArray[indexPath.item]
        print(game?.selectedNumber ?? 0)
        resultButton.isEnabled = true
        resultButton.backgroundColor = .black
    }
}

extension GameViewController {
    enum CollectionViewLayout {
        static let columnsCount = 5
        static let scrollDirection: UICollectionView.ScrollDirection = .horizontal
        static let minimumLineSpacing: CGFloat = DS.Spacing.small
        static let minimumInteritemSpacing: CGFloat = DS.Spacing.small
        static let sectionInset = UIEdgeInsets(top: DS.Spacing.small, left: DS.Spacing.small, bottom: DS.Spacing.small, right: DS.Spacing.small)
    }
}
