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
        print(magazine.date.toDate())
        cell.dateLabel.text = "\(magazine.date.toDate())"
        
        return cell
    }
    
    // MARK:  - TableViewDelegate
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
}
