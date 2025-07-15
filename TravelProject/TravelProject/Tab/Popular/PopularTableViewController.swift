//
//  PopularTableViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/15/25.
//

import UIKit

enum MenuSection: CaseIterable {
    case all
    case domestic
    case overseas
    
    var title: String {
        switch self {
        case .all: return "모두"
        case .domestic: return "국내"
        case .overseas: return "해외"
        }
    }
}

final class PopularViewController: UIViewController {
    
    let cityList = CityInfo().city
    var filteredCityList: [City] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var textFieldBgView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationTitle()
        setTableViewDelegate()
        setupSegmentControl()
    }
    
    private func configureNavigationTitle() {
        navigationItem.title = "인기 도시"
    }
    
    private func setTableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupSegmentControl() {
        citySegment.removeAllSegments()
        
        MenuSection.allCases.enumerated().forEach { (index, section) in
            citySegment.insertSegment(withTitle: section.title, at: index, animated: true)
        }

        citySegment.selectedSegmentIndex = 0
        filteredCityList = cityList
    }
    
    @IBAction func citySegmentTapped(_ sender: UISegmentedControl) {
        print(#function, sender.selectedSegmentIndex)
        
        switch sender.selectedSegmentIndex {
        case 0:
            filteredCityList = cityList
            tableView.reloadData()
        case 1:
            filteredCityList = cityList.filter { $0.domesticTravel }
            tableView.reloadData()
        case 2:
            filteredCityList = cityList.filter { !$0.domesticTravel}
            tableView.reloadData()
        default: break
        }
    }
    
    @IBAction func searchTextFieldDidEndOnExit(_ sender: UITextField) {
        // 엔터눌렀을 때
        print(#function)
    }
    
    
    @IBAction func searchTextFieldEditingChanged(_ sender: UITextField) {
        print(#function)
    }
    
    
}

// MARK: - UITableViewDataSource
extension PopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: PopularTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PopularTableViewCell.id)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.id, for: indexPath) as? PopularTableViewCell else { return UITableViewCell() }
        
        cell.configure(data: filteredCityList[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    

}

