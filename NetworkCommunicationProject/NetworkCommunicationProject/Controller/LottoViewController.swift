//
//  ViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

final class LottoViewController: UIViewController {

    let lottoView = LottoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        self.view = lottoView

    }


}

