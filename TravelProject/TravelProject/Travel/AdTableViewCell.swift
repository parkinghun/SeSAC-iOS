//
//  AdTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/12/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var adBgView: UIView!
    @IBOutlet var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 12
        bgView.clipsToBounds = true
        messageLabel.font = .boldSystemFont(ofSize: 18)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        adBgView.backgroundColor = .white
        adBgView.layer.cornerRadius = 4
        adBgView.clipsToBounds = true
        adLabel.text = "AD"
        adLabel.font = .systemFont(ofSize: 8)
        adLabel.textAlignment = .center
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
