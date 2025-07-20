//
//  TravelTableViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/11/25.
//

import UIKit
import Kingfisher
import Toast

final class TravelTableViewController: UITableViewController {
    
    private var travelInfo = TravelInfo()
    private let navigationTitle = "도시 상세 정보"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
    }
    
    private func setupNavigation() {
        navigationItem.setupWithBackButton(title: navigationTitle)
    }
    
    private func setupTableView() {
        let travelNib = UINib(nibName: TravelTableViewCell.id, bundle: nil)
        let adNib = UINib(nibName: TravelAdTableViewCell.id, bundle: nil)
        
        tableView.register(travelNib, forCellReuseIdentifier: TravelTableViewCell.id)
        tableView.register(adNib, forCellReuseIdentifier: TravelAdTableViewCell.id)
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
            let adCellId = String(describing: TravelAdTableViewCell.self)
            guard let adCell = tableView.dequeueReusableCell(withIdentifier: adCellId, for: indexPath) as? TravelAdTableViewCell else {
                return UITableViewCell()
            }
            
            adCell.configure(data: travel)
            
            return adCell
        } else {
            let travelCellId = String(describing: TravelTableViewCell.self)
            guard let travelCell = tableView.dequeueReusableCell(withIdentifier: travelCellId, for: indexPath) as? TravelTableViewCell else {
                return UITableViewCell()
            }
            
            travelCell.configure(data: travelInfo.travel[indexPath.row], index: indexPath.row)
            
            travelCell.completionHandler = { [weak self] index in
                guard let self else { return }
                self.likeButtonTapped(index: index)
            }
            
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let travel = travelInfo.travel[indexPath.row]
        guard let ad = travel.ad else { return }
        
        if ad {
            // navigationController - fullscreen 방식으로 present(모달)
            let storyboard = UIStoryboard(name: "AdDetail", bundle: nil)
            let id = String(describing: AdDetailViewController.self)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: id) as? AdDetailViewController else { return }
            nextVC.adTitle = travel.title
            
            let nav = UINavigationController(rootViewController: nextVC)
            nav.modalPresentationStyle = .fullScreen
            
            nav.isNavigationBarHidden = false
            present(nav, animated: true)
        } else {
            // push
            let storyboard = UIStoryboard(name: "TouristDestinations", bundle: nil)
            let id = String(describing: TouristDestinationsViewController.self)
            guard let nextVC = storyboard.instantiateViewController(withIdentifier: id) as? TouristDestinationsViewController else { return }
            
            nextVC.travel = travel
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    private func likeButtonTapped(index: Int) {
        travelInfo.travel[index].like?.toggle()
        tableView.reloadData()
        //        tableView.reloadRows(at: sender.tag, with: .automatic)  //
    }
}
