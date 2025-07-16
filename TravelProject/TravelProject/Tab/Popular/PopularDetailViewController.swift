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
        setupNavigation()
        configure()
    }
    
    private func setupNavigation() {
        navigationItem.title = "\(nameText) 정보"
    }
    
    private func configure() {
        cityImageView.downSampling(url: city?.cityImageURL)
        cityImageView.configure(contentMode: .scaleAspectFill)
        
        nameLabel.configure(text: nameText, font: .boldSystemFont(ofSize: 20), alignment: .center)
        explainLabel.configure(text: city?.cityExplain, alignment: .center)
    }
}
