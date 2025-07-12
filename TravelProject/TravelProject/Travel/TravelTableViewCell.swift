//
//  TravelTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/12/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {

    // title
    // description
    // travel_image
    // grade
    // save
    // like
    // ad
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var imageOuterView: UIView!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .boldSystemFont(ofSize: 25)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.textColor = .gray
        starImageView.image = UIImage(systemName: "star")
        saveLabel.textColor = .lightGray
        
        imageOuterView.layer.cornerRadius = 12
        imageOuterView.clipsToBounds = true
        travelImageView.contentMode = .scaleAspectFill
        
        likeButton.setTitle("", for: .normal)
//        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .red
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
