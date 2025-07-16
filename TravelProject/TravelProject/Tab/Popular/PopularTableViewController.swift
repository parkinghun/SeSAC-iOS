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
    var displayCityList: [City] = [] {
        didSet {
            if displayCityList.isEmpty {
                tableView.isHidden = true
                emptyViewLabel.isHidden = false
            } else {
                tableView.isHidden = false
                emptyViewLabel.isHidden = true
            }
            tableView.reloadData()
        }
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var textFieldBgView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var emptyViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        setTableViewDelegate()
        setupSegmentControl()
        configureUI()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "인기 도시"
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil )
        backBarButtonItem.tintColor = .gray
        navigationItem.backBarButtonItem = backBarButtonItem

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
        
        filteredCityList = getFilteredTravelList()
        displayCityList = getFilteredTravelList()
    }
    
    private func configureUI() {
        textFieldBgView.layer.cornerRadius = 12
        textFieldBgView.clipsToBounds = true
        textFieldBgView.layer.borderWidth = 1
        textFieldBgView.layer.borderColor = UIColor.gray.cgColor
        
        searchTextField.borderStyle = .none
        searchTextField.placeholder = "도시를 검색해보세요."
        
        searchButton.setTitle("", for: .normal)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .gray
        
        emptyViewLabel.text = "검색한 결과가 없습니다."
        emptyViewLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    @IBAction func citySegmentTapped(_ sender: UISegmentedControl) {
        print(#function, sender.selectedSegmentIndex)
        
        displayCityList = getFilteredTravelList()
    }
    
    @IBAction func searchTextFieldDidEndOnExit(_ sender: UITextField) {
        print(#function)
        applySearch(keyword: sender.text)
    }
    
    @IBAction func searchTextFieldEditingChanged(_ sender: UITextField) {
        print(#function)
        applySearch(keyword: sender.text)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        applySearch(keyword: searchTextField.text)
        searchTextField.resignFirstResponder()
    }
    
    private func getFilteredTravelList() -> [City] {
        switch citySegment.selectedSegmentIndex {
        case 0:
            filteredCityList = cityList
        case 1:
            filteredCityList = cityList.filter { $0.domesticTravel }
        case 2:
            filteredCityList = cityList.filter { !$0.domesticTravel}
        default:
            filteredCityList = []
        }
        
        return filteredCityList
    }
    
    private func applySearch(keyword: String?) {
        guard let keyword else { return }
        let key = keyword.lowercased().trimmingCharacters(in: .whitespaces)

        if keyword.isEmpty {
            displayCityList = filteredCityList
        } else {
            displayCityList = filteredCityList.filter { city in
                city.cityName.contains(key) ||
                city.cityEnglishName.lowercased().contains(key) ||
                city.cityExplain.contains(key)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension PopularViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: PopularTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PopularTableViewCell.id)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.id, for: indexPath) as? PopularTableViewCell else { return UITableViewCell() }
        
        cell.configure(data: displayCityList[indexPath.row])
        cell.HilightedMatchedText(keyword: searchTextField.text ?? "")
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        let storyboard = UIStoryboard(name: "PopularDetail", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: PopularDetailViewController.id) as? PopularDetailViewController else { return }
        
        vc.city = displayCityList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
