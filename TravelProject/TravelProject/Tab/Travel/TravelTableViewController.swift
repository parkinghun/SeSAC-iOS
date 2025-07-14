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
            // toast 띄우기 - 스크롤뷰 위치를 고정해야함.(CGPoint 문제인듯 ,xy 고정)
            view.makeToast("광고 셀입니다.", position: .bottom)
        }
    }
    
    private func likeButtonTapped(index: Int) {
        travelInfo.travel[index].like?.toggle()
        tableView.reloadData()
        //        tableView.reloadRows(at: sender.tag, with: .automatic)  //
    }
}
