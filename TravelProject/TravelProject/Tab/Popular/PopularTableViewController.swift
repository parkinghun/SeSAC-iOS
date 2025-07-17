//
//  PopularTableViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/15/25.
//

import UIKit

final class PopularViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var citySegment: UISegmentedControl!
    @IBOutlet var textFieldBgView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var emptyViewLabel: UILabel!
    
    let cityList = CityInfo().city
    var filteredCityList: [City] = []
    var displayCityList: [City] = [] {
        didSet {
            if displayCityList.isEmpty {
                collectionView.isHidden = true
                emptyViewLabel.isHidden = false
            } else {
                collectionView.isHidden = false
                emptyViewLabel.isHidden = true
            }
            collectionView.reloadData()
        }
    }
    
    private var menuSectoin = MenuSection.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCollectionView()
        setupSegmentControl()
        configure()
    }
    
    private func setupNavigation() {
        navigationItem.title = StaticText.navigationTitle.rawValue
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .gray
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: PopularCollectionViewCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PopularCollectionViewCell.id)

        setupFlowLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupFlowLayout() {
        let columnsCount = CollectionViewLayout.columnsCount
        let sectionSpacing = CollectionViewLayout.sectionSpacing
        let itemSpacing = CollectionViewLayout.itemSpacing
        let screenWidth = UIScreen.main.bounds.width
        
        let width = screenWidth - (sectionSpacing * 2) - (itemSpacing * CGFloat(columnsCount  - 1))
        let itemWidth = width / CGFloat(columnsCount)
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
   
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
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
    
    private func configure() {
        textFieldBgView.configure(cornerRadius: 12, borderWidth: 1, borderColor: UIColor.gray.cgColor)
        
        searchTextField.borderStyle = .none
        searchTextField.placeholder = StaticText.placeholder.rawValue  //nested enum
        
        searchButton.configure(image: UIImage(systemName: "magnifyingglass"), color: .gray)
        emptyViewLabel.configure(text: StaticText.emptyText.rawValue, font: .boldSystemFont(ofSize: 20))
    }
    
    @IBAction func citySegmentTapped(_ sender: UISegmentedControl) {
        print(#function, sender.selectedSegmentIndex)
        menuSectoin = MenuSection.allCases[sender.selectedSegmentIndex]
        displayCityList = getFilteredTravelList()
        dump(displayCityList)
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
        switch menuSectoin {
        case .all:
            filteredCityList = cityList
        case .domestic:
            filteredCityList = cityList.filter { $0.domesticTravel }
        case .overseas:
            filteredCityList = cityList.filter { !$0.domesticTravel }
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

// MARK: - UICollectionViewFlowLayout
extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayCityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.id, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = displayCityList[indexPath.item]
        cell.configure(item: item)
        cell.hilightedMatchedText(keyword: searchTextField.text ?? "")
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "PopularDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: PopularDetailViewController.id) as? PopularDetailViewController else { return }
        
        vc.city = displayCityList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PopularViewController {
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

    enum StaticText: String {
        case navigationTitle = "인기 도시"
        case placeholder = "도시를 검색해보세요."
        case emptyText = "검색한 결과가 없습니다."
    }
    
    enum CollectionViewLayout {
        static let columnsCount = 2
        static let sectionSpacing: CGFloat = 16
        static let itemSpacing: CGFloat = 16
    }
}
