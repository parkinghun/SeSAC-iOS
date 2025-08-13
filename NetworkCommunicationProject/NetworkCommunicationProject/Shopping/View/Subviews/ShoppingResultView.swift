//
//  ShoppingResultView.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/26/25.
//

import UIKit
import SnapKit

protocol ShoppingResultViewDelegate: AnyObject {
    func didSelectSort(_ sort: Sort)
}

final class ShoppingResultView: UIView {
    
    typealias DSFont = DesignSystem.Font
    weak private var delegate: ShoppingResultViewDelegate?
    
    let resultCountLabel: UILabel = {
        let label = UILabel()
        label.configure(font: DSFont.footnote, color: .green)
        return label
    }()
    
    let accuracyButton = FilterOptionButton(title: "정확도", foregroundColor: .black, backgroundColor: .white)
    let dateOrderButton = FilterOptionButton(title: "날짜순")
    let highPriceButton = FilterOptionButton(title: "가격높은순")
    let lowPriceButton = FilterOptionButton(title: "가격낮은순")
    
    lazy var buttonStackView = {
        let sv = UIStackView(arrangedSubviews: [accuracyButton, dateOrderButton, highPriceButton, lowPriceButton])
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    let collectionView: UICollectionView = {
        let columnsCount = 2
        let cellWidth = UIScreen.main.bounds.width - (8 * 2) - (8 * CGFloat(columnsCount - 1))
        let itemWidth = cellWidth / CGFloat(columnsCount)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: itemWidth, height: 300)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        return cv
    }()
    
    let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureView()
        configureButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDelegation(_ delegate: ShoppingResultViewDelegate) {
        self.delegate = delegate
    }
    
    func configure(_ searchResult: SearchResult) {
        guard let count = searchResult.formattedCount else { return }
        resultCountLabel.text = "\(count) 개의 검색 결과"
    }
    
    private func configureButtonActions() {
        let buttons = [accuracyButton, dateOrderButton, highPriceButton, lowPriceButton]
        
        for (index, button) in buttons.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(handleSortButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    private func updateButtonUI(_ button: UIButton) {
        let buttons = [accuracyButton, dateOrderButton, highPriceButton, lowPriceButton]
        
        buttons.forEach {
            if $0 == button {
                $0.configuration?.baseForegroundColor = .black
                $0.configuration?.baseBackgroundColor = .white
            } else {
                $0.configuration?.baseForegroundColor = .white
                $0.configuration?.baseBackgroundColor = .black
            }
        }
    }
    
    @objc private func handleSortButtonTapped(_ sender: UIButton) {
        updateButtonUI(sender)
        
        let sorts = Sort.allCases
        delegate?.didSelectSort(sorts[sender.tag])
    }
}

extension ShoppingResultView: ViewDesignProtocol {
    func configureHierachy() {
        let components: [UIView] = [resultCountLabel, buttonStackView, collectionView, horizontalCollectionView]
        components.forEach {
            self.addSubview($0)
        }
    }
    
    func configureLayout() {
        resultCountLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).inset(8)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.equalTo(self).offset(8)
            $0.top.equalTo(resultCountLabel.snp.bottom).offset(8)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(buttonStackView.snp.bottom).offset(8)
            $0.bottom.equalTo(horizontalCollectionView.snp.top).offset(-10)
        }
        
        horizontalCollectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
    }
    
    func configureView() {
        self.backgroundColor = .black
    }
}
