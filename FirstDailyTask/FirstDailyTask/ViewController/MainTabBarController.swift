//
//  MainTabBarController.swift
//  FirstDailyTask
//
//  Created by 박성훈 on 7/2/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 탭바 변경시 흰색 화면 보이는 것 방지
        self.view.backgroundColor = .black
    }
}
