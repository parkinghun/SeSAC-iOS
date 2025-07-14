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
        configureUI()
    }
    
    private func configureUI() {
        configureImageView()
        configureLabel()
    }
    
    private func configureImageView() {
        mainImageView.layer.cornerRadius = 12
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFill
    }
    
    private func configureLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        subtitleLabel.textColor = .gray
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
}
