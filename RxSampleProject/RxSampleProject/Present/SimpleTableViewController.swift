//
//  SimpleTableViewController.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleTableViewController: UIViewController {
    
    private lazy var tableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tv
    }()
    
    private let items = Observable.just((0...20).map { "\($0)" })
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureLayout()
        bind()
    }
    
    private func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
                var content = cell.defaultContentConfiguration()
                content.text = "\(element) @ row \(row)"
                
                cell.contentConfiguration = content
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(with: self) { owner, value in
                owner.presentAlert("Tapped '\(value)'")
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(with: self) { owner, indexPath in
                owner.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            }
            .disposed(by: disposeBag)
    }
}

private extension SimpleTableViewController {
    func configureHierachy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
    
    func rootViewController() -> UIViewController? {
        return self.view.window?.rootViewController
    }
}

