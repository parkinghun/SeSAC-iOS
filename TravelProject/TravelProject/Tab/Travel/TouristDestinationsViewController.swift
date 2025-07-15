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
        configure()
    }
    
    private func configure() {
        configureNavigationTitle()
        setData()
        configureImageView()
        configureLabel()
        configureButton()
    }
    
    private func configureNavigationTitle() {
        navigationItem.title = "관광지 화면"
    }
    
    private func setData() {
        travelImageView.kf.setImage(with: travel?.imageURL)
        nameLabel.text = travel?.title
        descriptionLabel.text = travel?.description
    }
    
    private func configureImageView() {
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 12
        travelImageView.clipsToBounds = true
    }
    
    private func configureLabel() {
        configureLabel(nameLabel, size: 35)
        configureLabel(descriptionLabel, size: 20)
    }
    
    private func configureLabel(_ label: UILabel, size: CGFloat) {
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: size)
        label.numberOfLines = 0
    }
    
    private func configureButton() {
        popButton.setTitle("다른 관광지 보러 가기", for: .normal)
        popButton.setTitleColor(.white, for: .normal)
        popButton.backgroundColor = .systemBlue
        popButton.layer.cornerRadius = popButton.bounds.height / 2
        popButton.clipsToBounds = true
    }
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
