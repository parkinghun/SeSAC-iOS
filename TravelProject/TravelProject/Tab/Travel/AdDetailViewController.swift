//
//  AdDetailViewController.swift
//  TravelProject
//
//  Created by 박성훈 on 7/15/25.
//

import UIKit

final class AdDetailViewController: UIViewController {
    
    var adTitle: String?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        configure()
    }
    
    private func setupNavigation() {
        navigationItem.title = "광고 화면"
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButtonItemTapped))
        navigationItem.leftBarButtonItem = backButtonItem
        
        navigationController?.navigationBar.tintColor = .gray
    }
    
    private func configure() {
        titleLabel.configure(text: adTitle, font: .boldSystemFont(ofSize: 30), alignment: .center, numberOfLines: 0)
    }
    
    @objc private func backButtonItemTapped() {
        dismiss(animated: true)
    }
}

