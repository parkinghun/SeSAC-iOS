//
//  BoxOfficeViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    let boxOfficeView = BoxOfficeView()
    
    override func loadView() {
        self.view = boxOfficeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        boxOfficeView.tableView.delegate = self
        boxOfficeView.tableView.dataSource = self
        
        boxOfficeView.tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.id)
        
        boxOfficeView.tableView.rowHeight = 60
    }
}

extension BoxOfficeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieInfo.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = boxOfficeView.tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.id, for: indexPath) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        
        cell.configure(row: MovieInfo.movies[indexPath.row], rank: indexPath.row + 1)
        return cell
    }
    
}

extension BoxOfficeViewController: UITableViewDelegate {
    
}
