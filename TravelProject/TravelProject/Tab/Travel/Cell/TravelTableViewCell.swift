//
//  TravelTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/14/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    static let id = "TravelTableViewCell"
    var completionHandler: ((Int) -> Void)?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starImageView: [UIImageView]!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var imageOuterView: UIView!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureDefault()
    }
    
    func configure(data travel: Travel, index: Int) {
        titleLabel.text = travel.title
        descriptionLabel.text = travel.description
        saveLabel.text = travel.saveText
        
        travelImageView.downSampling(url: travel.imageURL)
        likeButton.setImage(travel.likeImage, for: .normal)
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        likeButton.tag = index

        drawStarGrade(data: travel)
    }
    
    private func drawStarGrade(data travel: Travel) {
        guard let grade = travel.grade else {
            for index in 0..<starImageView.count {
                starImageView[index].image = UIImage(systemName: "star")
            }
            return
        }
        for index in 0..<starImageView.count {
            starImageView[index].image = UIImage(systemName: Int(grade) >= (index + 1) ? "star.fill" : "star")
        }
    }
    
    private func configureDefault() {
        titleLabel.configure(font: .boldSystemFont(ofSize: 25))
        descriptionLabel.configure(font: .systemFont(ofSize: 20), color: .gray, numberOfLines: 0)
        saveLabel.configure(font: .systemFont(ofSize: 12), color: .lightGray)
        
        starImageView.forEach { $0.tintColor = .orange }
        travelImageView.contentMode = .scaleAspectFill
        imageOuterView.setCornerRadius(to: 12)
        
        likeButton.configure(color: . red)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        completionHandler?(sender.tag)
    }
}
