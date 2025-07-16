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
        cityImageView.downSampling(url: data.cityImageURL)
    }
    
    func HilightedMatchedText(keyword: String) {
        cityNameLabel.asFontColor(targetString: keyword)
        cityExplainLabel.asFontColor(targetString: keyword)
    }
    
    private func configureDefault() {
        bgView.configure(cornerRadius: 20)
        bgView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        // 그림자

        cityExPlainBgView.configure(bgColor: .black, opacity: 0.6)
        
        cityNameLabel.configure(font: .boldSystemFont(ofSize: 30), color: .white)
        cityExplainLabel.configure(color: .white)
        cityImageView.configure(contentMode: .scaleAspectFill)
    }
}
