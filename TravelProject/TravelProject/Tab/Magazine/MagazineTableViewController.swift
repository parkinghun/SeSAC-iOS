//
//  MagazineTableViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import UIKit
import Kingfisher

final class MagazineTableViewController: UITableViewController {
    
    let magazineInfo = MagazineInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        registerNib()
    }
    
    private func configure() {
        configureNavigatoinTitle()
        configureTableView()
    }
    
    private func configureNavigatoinTitle() {
        self.navigationItem.title = "SeSAC TRAVEL"
    }
    
    private func configureTableView() {
        self.tableView.separatorStyle = .none
    }
    
    private func registerNib() {
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
        configureCell(cell, data: magazine)
        
        return cell
    }
    
    private func configureCell(_ cell: MagazineTableViewCell, data magazine: Magazine) {
        let imageUrl = URL(string: magazine.photo_image)
        cell.mainImageView.kf.setImage(with: imageUrl)
        cell.titleLabel.text = magazine.title
        cell.subtitleLabel.text = magazine.subtitle
        cell.dateLabel.text = dateFormat(magazine.date)
    }
    
    private func dateFormat(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        
        if let date = dateFormatter.date(from: dateString) {  // 데이터 객체
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy년 MM월 dd일"
            let formattedDate = dateFormatter.string(from: date)  // String
            return formattedDate
        } else {
            return ""
        }
    }
    
    // MARK:  - TableViewDelegate
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
