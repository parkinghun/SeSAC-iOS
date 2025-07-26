//
//  ShoppingResultView.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/26/25.
//

import UIKit
import SnapKit

protocol ShoppingResultViewDelegate: AnyObject {
    func tappedAccuracyButton()
    func tappedDateOrderButto()
    func tappedHighPriceButto()
    func tappedLowPriceButton()
}

final class ShoppingResultView: UIView {
    
    typealias DSFont = DesignSystem.Font
    weak private var delegate: ShoppingResultViewDelegate?
    
    let resultCountLabel: UILabel = {
        let label = UILabel()
        label.configure(font: DSFont.footnote, color: .green)
        return label
    }()
    
    let accuracyButton = FilterOptionButton(title: "정확도", titleColor: .black, backgroundColor: .white)
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
        accuracyButton.addTarget(self, action: #selector(handleAccuracyButtonTapped(_:)), for: .touchUpInside)
        dateOrderButton.addTarget(self, action: #selector(handleDateOrderButtonTapped(_:)), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(handleHighPriceButtonTapped(_:)), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(handleLowPriceButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func updateButtonUI(_ button: UIButton) {
        let buttons = [accuracyButton, dateOrderButton, highPriceButton, lowPriceButton]
        
        buttons.forEach {
            if $0 == button {
                $0.setTitleColor(.black, for: .normal)
                $0.backgroundColor = .white
            } else {
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = .black
            }
        }
    }
    
    @objc private func handleAccuracyButtonTapped(_ sender: UIButton) {
        updateButtonUI(sender)
        delegate?.tappedAccuracyButton()
    }
    
    @objc private func handleDateOrderButtonTapped(_ sender: UIButton) {
        updateButtonUI(sender)
        delegate?.tappedDateOrderButto()
    }
    
    @objc private func handleHighPriceButtonTapped(_ sender: UIButton) {
        updateButtonUI(sender)
        delegate?.tappedHighPriceButto()
    }
    
    @objc private func handleLowPriceButtonTapped(_ sender: UIButton) {
        updateButtonUI(sender)
        delegate?.tappedLowPriceButton()
    }
    
}

extension ShoppingResultView: ViewDesignProtocol {
    func configureHierachy() {
        let components: [UIView] = [resultCountLabel, buttonStackView, collectionView]
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
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(buttonStackView.snp.bottom).offset(8)
        }
    }
    
    func configureView() {
        self.backgroundColor = .black
    }
}
