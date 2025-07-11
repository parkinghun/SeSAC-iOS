//
//  SettingsTableViewController.swift
//  Tamagotchi
//
//  Created by 박성훈 on 7/10/25.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let list = [["공지사항", "실험실", "버전 정보"],
                ["개인/보안", "알림", "채팅", "멀티프로필"],
                ["고객센터/도움말"]]
    let sectionHeaders = ["전체 설정", "개인 설정", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(#function)
        return sectionHeaders.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return list[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print(#function)
        return sectionHeaders[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function)
        return 44
    }
}
