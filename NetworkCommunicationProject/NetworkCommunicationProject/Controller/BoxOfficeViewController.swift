//
//  BoxOfficeViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

final class BoxOfficeViewController: UIViewController {
    
    private let boxOfficeView = BoxOfficeView()
    private let movieManager = MovieManager()
    private var movies: [Movie] = MovieInfo.movies {
        didSet {
            boxOfficeView.tableView.reloadData()
        }
    }
    
    
    override func loadView() {
        self.view = boxOfficeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDelegate()
    }
    
    func setupTableView() {
        boxOfficeView.tableView.delegate = self
        boxOfficeView.tableView.dataSource = self
        
        boxOfficeView.tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.id)
        
        boxOfficeView.tableView.rowHeight = 60
    }
    
    func setupDelegate() {
        boxOfficeView.delegate = self
        boxOfficeView.searchTextField.delegate = self
    }
}

extension BoxOfficeViewController: BoxOfficeViewDelegate {
    func tappedSearchButton() {
        print(#function)
        movies = movieManager.shuffleMovies()
    }
}

extension BoxOfficeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = boxOfficeView.tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.id, for: indexPath) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        
        cell.configure(row: movies[indexPath.row], rank: indexPath.row + 1)
        return cell
    }
    
}

extension BoxOfficeViewController: UITableViewDelegate {
    
}

extension BoxOfficeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        movies = movieManager.shuffleMovies()
        boxOfficeView.searchTextField.resignFirstResponder()
        return true
    }
}
