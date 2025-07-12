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
    let adsInfo = AdInfo()
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
            
            // 0 1 2 3 (-0)
            // 5(4) 6(5) 7(6) (-1)
            // 9(7) 10(8) 11(9) (-2)
            // 13(10) 14 15 (-3)
            
//            let index = indexPath.row - (indexPath.row / 4)
            let travel = travelInfo.travel[indexPath.row]
            
            travelCell.titleLabel.text = travel.title
            travelCell.descriptionLabel.text = travel.description
            travelCell.saveLabel.text = "(3) ∙ 저장 \(travel.save ?? 0)"
            travelCell.travelImageView.kf.setImage(with: travel.imageURL)
            travelCell.likeButton.setImage(travel.likeImage, for: .normal)
            travelCell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
            travelCell.likeButton.tag = indexPath.row
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
        // 버튼을 누르면 하트가 바뀌어야 함.
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadData()
    }
    
}
