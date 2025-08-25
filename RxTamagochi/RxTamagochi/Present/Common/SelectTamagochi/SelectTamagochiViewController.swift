//
//  SelectTamagochiViewController.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SelectTamagochiViewController: UIViewController, ConfigureViewControllerProtocol {
    
    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout())
        cv.register(SelectTamagochiCollectionViewCell.self, forCellWithReuseIdentifier: SelectTamagochiCollectionViewCell.identifier)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let viewModel: SelectTamagochiViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: SelectTamagochiViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        bind()
        configureBackgroundColor()
    }
    
    func bind() {
        let input = SelectTamagochiViewModel.Input(modelSelected: collectionView.rx.modelSelected(TamagochiType.self))
        let output = viewModel.transform(input: input)
        
        output.data
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: SelectTamagochiCollectionViewCell.identifier, cellType: SelectTamagochiCollectionViewCell.self)) { item, element, cell in
                
                cell.tamagochiView.configure(item: element)
            }
            .disposed(by: disposeBag)
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .estimated(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func configureHierachy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
