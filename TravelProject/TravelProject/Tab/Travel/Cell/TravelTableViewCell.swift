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
        
        configureUI()
    }
    
    func configure(data travel: Travel, index: Int) {
        titleLabel.text = travel.title
        descriptionLabel.text = travel.description
        saveLabel.text = travel.saveText
        travelImageView.kf.setImage(with: travel.imageURL)
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
    
    
    private func configureUI() {
        configureLabel()
        configureView()
        configureButton()
    }
    
    private func configureLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 25)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.textColor = .gray
        
        saveLabel.textColor = .lightGray
        saveLabel.font = .systemFont(ofSize: 12)
    }
    
    private func configureView() {
        starImageView.forEach { $0.tintColor = .orange }
        travelImageView.contentMode = .scaleAspectFill
        
        imageOuterView.layer.cornerRadius = 12
        imageOuterView.clipsToBounds = true
    }
    
    private func configureButton() {
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .red
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        completionHandler?(sender.tag)
    }
}
