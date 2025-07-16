//
//  MagazineTableViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import UIKit
import Kingfisher

final class MagazineTableViewController: UITableViewController {
    
    private let magazineInfo = MagazineInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupTableView()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "SeSAC TRAVEL"
    }
    
    private func setupTableView() {
        self.tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        registerCell()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: MagazineTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MagazineTableViewCell.id)
    }
    
    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.id, for: indexPath) as? MagazineTableViewCell else {
            return UITableViewCell()
        }
        
        let magazine = magazineInfo.magazine[indexPath.row]
        cell.configure(data: magazine)
        
        return cell
    }
    
    // MARK:  - TableViewDelegate
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
