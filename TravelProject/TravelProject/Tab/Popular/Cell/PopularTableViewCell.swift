//
//  PopularTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/15/25.
//

import UIKit

class PopularTableViewCell: UITableViewCell {

    
    @IBOutlet var bgView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExPlainBgView: UIView!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
