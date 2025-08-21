//
//  DetailViewController.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/20/25.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    let label = {
        let label = UILabel()
        label.text = "DetailVC"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(name: String) {
        label.text = name
    }
}
