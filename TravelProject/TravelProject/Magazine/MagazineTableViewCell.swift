//
//  MagazineTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/12/25.
//

import UIKit

final class MagazineTableViewCell: UITableViewCell {
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
