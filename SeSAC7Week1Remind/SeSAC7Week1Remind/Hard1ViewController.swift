//
//  Hard1ViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 박성훈 on 7/7/25.
//

import UIKit

class Hard1ViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
    }
    

}
