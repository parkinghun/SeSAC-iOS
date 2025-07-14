//
//  TravelTableViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import UIKit
import Kingfisher

final class TravelTableViewController: UITableViewController {
    
    private var travelInfo = TravelInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitle()
        registerNib()
    }
    
    private func configureNavigationTitle() {
        navigationItem.title = "도시 상세 정보"
    }
    
    private func registerNib() {
        let travelNib = UINib(nibName: TravelTableViewCell.id, bundle: nil)
        tableView.register(travelNib, forCellReuseIdentifier: TravelTableViewCell.id)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travelInfo.travel[indexPath.row]
        
        guard let ad = travel.ad else {
            return UITableViewCell()
        }
        
        if ad  {
            let adCellId = String(describing: AdTableViewCell.self)
            guard let adCell = tableView.dequeueReusableCell(withIdentifier: adCellId, for: indexPath) as? AdTableViewCell else {
                return UITableViewCell()
            }
       
            configureAdCell(adCell, data: travel)
            return adCell
        } else {
            let travelCellId = String(describing: TravelTableViewCell.self)
            guard let travelCell = tableView.dequeueReusableCell(withIdentifier: travelCellId, for: indexPath) as? TravelTableViewCell else {
                return UITableViewCell()
            }
            
            let travel = travelInfo.travel[indexPath.row]
            configureTravelCell(travelCell, data: travel, index: indexPath.row)
            
            return travelCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let travel = travelInfo.travel[indexPath.row]
        guard let ad = travel.ad else { return 200 }
        
        if ad {
            return 120
        } else {
            return 200
        }
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadData()
//        tableView.reloadRows(at: sender.tag, with: .automatic)  //
    }
    
    private func configureTravelCell(_ cell: TravelTableViewCell, data travel: Travel, index: Int) {
        let formattedLikie = travel.formattedNumber(travel.likeCount)
        let formattedSave = travel.formattedNumber(travel.save)
        
        cell.titleLabel.text = travel.title
        cell.descriptionLabel.text = travel.description
        cell.saveLabel.text = "(\(formattedLikie)) ∙ 저장 \(formattedSave)"
        cell.travelImageView.kf.setImage(with: travel.imageURL)
        cell.likeButton.setImage(travel.likeImage, for: .normal)
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        cell.likeButton.tag = index
        
        let grade = Int(travel.grade ?? 0)
        for index in 0..<cell.starImageView.count {
            cell.starImageView[index].image = UIImage(systemName: grade >= (index + 1) ? "star.fill" : "star")
        }
    }
    
    private func configureAdCell(_ cell: AdTableViewCell, data travel: Travel) {
        cell.bgView.backgroundColor = travel.adBgColor
        cell.messageLabel.text = travel.title
    }
}
