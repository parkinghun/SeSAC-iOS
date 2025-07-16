//
//  TouristDestinationsViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/15/25.
//

import UIKit


final class TouristDestinationsViewController: UIViewController {

    var travel: Travel?

    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var popButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        configure()
    }
    
    private func setupNavigation() {
        navigationItem.title = "관광지 화면"
    }
    
    private func configure() {
        travelImageView.downSampling(url: travel?.imageURL)
        travelImageView.configure(cornerRadius: 12, contentMode: .scaleAspectFill)
        
        descriptionLabel.configure(text: travel?.description)
        
        nameLabel.configure(text: travel?.title, font: .boldSystemFont(ofSize: 35), alignment: .center, numberOfLines: 0)
        descriptionLabel.configure(text: travel?.description, font: .boldSystemFont(ofSize: 20), alignment: .center, numberOfLines: 0)
     
        popButton.configure(title: "다른 관광지 보러 가기",
                            color: .white,
                            bgColor: .systemBlue,
                            cornerRadius: popButton.bounds.height / 2)
    }
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
