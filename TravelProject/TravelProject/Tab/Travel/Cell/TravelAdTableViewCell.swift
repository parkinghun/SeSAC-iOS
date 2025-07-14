//
//  TravelAdTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/14/25.
//

import UIKit

class TravelAdTableViewCell: UITableViewCell {

    static let id = "TravelAdTableViewCell"
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var adBgView: UIView!
    @IBOutlet var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    func configure(data travel: Travel) {
        bgView.backgroundColor = travel.adBgColor
        messageLabel.text = travel.title
    }
    
    private func configureUI() {
        configureBgView()
        configureLabel()
    }
    
    private func configureBgView() {
        bgView.layer.cornerRadius = 12
        bgView.clipsToBounds = true
        
        adBgView.backgroundColor = .white
        adBgView.layer.cornerRadius = 4
        adBgView.clipsToBounds = true
    }
    
    private func configureLabel() {
        messageLabel.font = .boldSystemFont(ofSize: 18)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        adLabel.text = "AD"
        adLabel.font = .systemFont(ofSize: 8)
        adLabel.textAlignment = .center
    }
}
