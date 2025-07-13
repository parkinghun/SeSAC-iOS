//
//  TravelTableViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import UIKit
import Kingfisher
class TravelTableViewController: UITableViewController {
    
    var travelInfo = TravelInfo()
    let adBgColor: [UIColor] = [.systemPink, .green, .orange, .cyan]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travelInfo.travel[indexPath.row]

        if indexPath.row > 0,
           indexPath.row % 4 == 0 {
            let adCellId = String(describing: AdTableViewCell.self)
            guard let adCell = tableView.dequeueReusableCell(withIdentifier: adCellId, for: indexPath) as? AdTableViewCell else {
                return UITableViewCell()
            }
            
            let isValid = indexPath.row / 4 <= adBgColor.count
            let adIndex = indexPath.row / 4 - 1
            adCell.bgView.backgroundColor = isValid ? adBgColor[adIndex] : .magenta
            adCell.messageLabel.text = travel.title
            
            return adCell
        }  else {
            let travelCellId = String(describing: TravelTableViewCell.self)
            guard let travelCell = tableView.dequeueReusableCell(withIdentifier: travelCellId, for: indexPath) as? TravelTableViewCell else {
                return UITableViewCell()
            }

            let travel = travelInfo.travel[indexPath.row]
            let formattedLikie = travel.formattedNumber(travel.likeCount)
            let formattedSave = travel.formattedNumber(travel.save)
            
            travelCell.titleLabel.text = travel.title
            travelCell.descriptionLabel.text = travel.description
            travelCell.saveLabel.text = "(\(formattedLikie)) ∙ 저장 \(formattedSave)"
            travelCell.travelImageView.kf.setImage(with: travel.imageURL)
            travelCell.likeButton.setImage(travel.likeImage, for: .normal)
            travelCell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
            travelCell.likeButton.tag = indexPath.row
            
            let grade = Int(travel.grade ?? 0)
            for index in 0..<travelCell.starImageView.count {
                travelCell.starImageView[index].image = UIImage(systemName: grade >= (index + 1) ? "star.fill" : "star")
            }
            
            return travelCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 0,
           indexPath.row % 4 == 0 {
            return 120
        } else {
            return 200
        }
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        print(sender.tag)
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadData()
    }
}
