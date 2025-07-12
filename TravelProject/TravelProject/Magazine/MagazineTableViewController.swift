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
        print(#function)
        configureNavigatoinTitle()
        configureTableView()
    }
    
    private func configureNavigatoinTitle() {
        self.navigationItem.title = "SeSAC TRAVEL"
    }
    
    private func configureTableView() {
        self.tableView.separatorStyle = .none
    }
    
    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return magazineInfo.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let identifier = String(describing: MagazineTableViewCell.self)
        print(identifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MagazineTableViewCell else {
            return UITableViewCell()
        }
        
        let magazine = magazineInfo.magazine[indexPath.row]
        
        let imageUrl = URL(string: magazine.photo_image)
        cell.mainImageView.kf.setImage(with: imageUrl)
        cell.titleLabel.text = magazine.title
        cell.subtitleLabel.text = magazine.subtitle
        cell.dateLabel.text = dateFormat(magazine.date)
        
        return cell
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
