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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = String(describing: TravelTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TravelTableViewCell else {
            return UITableViewCell()
        }
        
        let travel = travelInfo.travel[indexPath.row]
        
        cell.titleLabel.text = travel.title
        cell.descriptionLabel.text = travel.description
        cell.saveLabel.text = "(3) ∙ 저장 \(travel.save ?? 0)"
        cell.travelImageView.kf.setImage(with: travel.imageURL)
        cell.likeButton.setImage(travel.likeImage, for: .normal)
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
 
    @objc private func likeButtonTapped(_ sender: UIButton) {
        print(sender.tag)
        // 버튼을 누르면 하트가 바뀌어야 함.
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadData()
    }
    

}
