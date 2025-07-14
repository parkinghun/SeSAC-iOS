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
        dateLabel.text = dateFormat(magazine.date)  // 리팩토링 필요

    }
    
    private func dateFormat(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        
        if let date = dateFormatter.date(from: dateString) {  // 데이터 객체
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy년 MM월 dd일"
            let formattedDate = dateFormatter.string(from: date)  // String
            return formattedDate
        } else {
            return ""
        }
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
