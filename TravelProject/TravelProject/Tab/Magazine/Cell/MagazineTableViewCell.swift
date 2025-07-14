//
//  MagazineTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/14/25.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    
    static let id = "MagazineTableViewCell"
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        configureDefault()
    }
    
    func configure(data magazine: Magazine) {
        configureMainImageView(magazine: magazine)
        configureTitleLabel(magazine: magazine)
        configureSubtitleLabel(magazine: magazine)
        configureDateLabel(magazine: magazine)
    }
    
    private func configureMainImageView(magazine: Magazine) {
        mainImageView.kf.setImage(with: magazine.imageUrl)
    }
    
    private func configureTitleLabel(magazine: Magazine) {
        titleLabel.text = magazine.title
    }
    
    private func configureSubtitleLabel(magazine: Magazine) {
        subtitleLabel.text = magazine.subtitle
    }
    
    private func configureDateLabel(magazine: Magazine) {
        dateLabel.text = magazine.formattedDate

    }
    
    private func configureDefault() {
        configureImageViewDefault()
        configureLabelDefault()
    }
    
    private func configureImageViewDefault() {
        mainImageView.layer.cornerRadius = 12
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFill
    }
    
    private func configureLabelDefault() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        subtitleLabel.textColor = .gray
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
}
