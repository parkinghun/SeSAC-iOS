//
//  PopularTableViewCell.swift
//  TravelProject
//
//  Created by 박성훈 on 7/15/25.
//

import UIKit

final class PopularTableViewCell: UITableViewCell {

    static let id = "PopularTableViewCell"
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExPlainBgView: UIView!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureDefault()
    }
    
    func configure(data: City) {
        cityNameLabel.text = data.nameLabelText
        cityExplainLabel.text = data.cityExplain
        cityImageView.kf.setImage(with: data.cityImageURL)
    }
    
    private func configureDefault() {
        configureBgView()
        configureLabel()
        configureImageView()
    }

    private func configureBgView() {
        bgView.layer.cornerRadius = 20
        bgView.clipsToBounds = true
        bgView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        // 그림자
        
        cityExPlainBgView.backgroundColor = .black
        cityExPlainBgView.layer.opacity = 0.6
    }
    
    private func configureLabel() {
        cityNameLabel.textColor = .white
        cityNameLabel.font = .boldSystemFont(ofSize: 30)
        
        cityExplainLabel.textColor = .white
    }
    
    private func configureImageView() {
        cityImageView.contentMode = .scaleAspectFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
