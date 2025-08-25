//
//  BoxOfficeViewController.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


final class BoxOfficeViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()

    let viewModel = BoxOfficeViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    func bind() {
        let input = BoxOfficeViewModel.Input(
            query: searchBar.rx.text.orEmpty,
            searchTapped: searchBar.rx.searchButtonClicked)
        let output = viewModel.transform(input: input)
        
        output.data
            .bind(to: tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.identifier, cellType: BoxOfficeTableViewCell.self)) { row, element, cell in
                
                cell.usernameLabel.text = element.movieNm
                
            }
            .disposed(by: disposeBag)
    }
    
    func configure() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar

        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }
}
