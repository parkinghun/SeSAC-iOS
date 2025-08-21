//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HomeworkViewController: UIViewController {
    
    private let tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()
    
    private let viewModel = HomeworkViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        let input = HomeworkViewModel.Input(
            tableCellModelSelected: tableView.rx.modelSelected(Person.self),
            collectionCellModelSelected: collectionView.rx.modelSelected(Person.self),
            searchButtonClicked: searchBar.rx.searchButtonClicked,
            searchBarText: searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.users
            .bind(to: tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self)) { [weak self] row, element, cell in
                guard let self else { return }
                cell.configure(row: element)
                
                cell.detailButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let vc = DetailViewController()
                        vc.configure(name: element.name)
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                    .disposed(by: disposeBag)
            }
            .disposed(by: disposeBag)
        
        
        output.selectedUsers
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) { item, element, cell in
                cell.configure(item: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        //        navigationItem.titleView = searchBar
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide )
            make.horizontalEdges.equalToSuperview()
        }
        
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(0)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
