//
//  PopularTableViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/15/25.
//

import UIKit

class PopularViewController: UIViewController {
    
    let cityList = CityInfo().city
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var citySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationTitle()
        setTableViewDelegate()
    }
    
    private func configureNavigationTitle() {
        navigationItem.title = "인기 도시"
    }
    
    private func setTableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func citySegmentTapped(_ sender: UISegmentedControl) {
        print(#function, sender.selectedSegmentIndex)
    }
    
}

// MARK: - UITableViewDataSource
extension PopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: PopularTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PopularTableViewCell.id)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.id, for: indexPath) as? PopularTableViewCell else { return UITableViewCell() }
        
        cell.configure(data: cityList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

}

