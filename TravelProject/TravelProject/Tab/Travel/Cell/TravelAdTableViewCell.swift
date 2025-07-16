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
        configureDefault()
    }

    func configure(data travel: Travel) {
        bgView.backgroundColor = travel.adBgColor
        messageLabel.text = travel.title
    }
    
    private func configureDefault() {
        bgView.setCornerRadius(to: 12)
        adBgView.configure(cornerRadius: 4, bgColor: .white)
        
        messageLabel.configure(font: .boldSystemFont(ofSize: 18), alignment: .center, numberOfLines: 0)
        adLabel.configure(text: "AD", font: .systemFont(ofSize: 8), alignment: .center)
    }
}
