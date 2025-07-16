//
//  PopularDetailViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/16/25.
//

import UIKit

final class PopularDetailViewController: UIViewController {

    static var id = "PopularDetailViewController"

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    var city: City?
    
    var nameText: String {
        guard let city else { return "" }
        return "\(city.cityName) | \(city.cityEnglishName)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitle()
        configureImageView()
        configureLabel()
    }
    
    private func configureNavigationTitle() {
        navigationItem.title = "\(nameText) 정보"
    }
    
    private func configureImageView() {
        cityImageView.kf.setImage(with: city?.cityImageURL)
        cityImageView.contentMode = .scaleAspectFill
    }
    
    private func configureLabel() {
        nameLabel.text = nameText
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textAlignment = .center
        
        explainLabel.text = city?.cityExplain
        explainLabel.textAlignment = .center
    }
}
