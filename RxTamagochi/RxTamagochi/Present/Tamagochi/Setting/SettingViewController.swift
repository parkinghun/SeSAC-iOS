//
//  SettingViewController.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/22/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingViewController: UIViewController, ConfigureViewControllerProtocol {
    private let tableView = {
        let tv =  UITableView(frame: .zero, style: .plain)
        tv.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tv.backgroundColor = .clear
        tv.rowHeight = 60
        return tv
    }()
    
    private let viewModel: SettingViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: SettingViewModel) {
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
        setupNavigationBackButtonStyle()
        configureBackgroundColor()
        navigationItem.title = "설정"
    }
    
    func bind() {
        let input = SettingViewModel.Input(
            selectedSetting: tableView.rx.modelSelected(SettingRow.self))
        let output = viewModel.transform(input: input)
        
        output.cellData
            .drive(tableView.rx.items(cellIdentifier: SettingTableViewCell.identifier, cellType: SettingTableViewCell.self)) { row, element, cell in
                cell.configure(row: element)
            }
            .disposed(by: disposeBag)
        
        output.deleteAlert
            .asDriver(onErrorJustReturn: .init(title: "", message: "", ok: "", cancel: ""))
            .drive(with: self) { owner, alert in
                owner.showAlert(alertStyle: alert)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureHierachy() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
    
}
