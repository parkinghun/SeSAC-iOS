//
//  BoxOfficeViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit
import Alamofire

final class BoxOfficeViewController: UIViewController {
    
    private let boxOfficeView = BoxOfficeView()
    private var dailyBoxOfficeList: [BoxOffice] = [] {
        didSet {
            boxOfficeView.tableView.reloadData()
        }
    }
    
    var yesterDay: String {
        let now = Date()  //현재
        let yesterday = now - 86400 //어제
        return yesterday.toFormattedString()
    }
    
    override func loadView() {
        self.view = boxOfficeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDelegate()
        callRequest(date: yesterDay)
    }
    
    private func setupTableView() {
        boxOfficeView.tableView.delegate = self
        boxOfficeView.tableView.dataSource = self
        
        boxOfficeView.tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.id)
        boxOfficeView.tableView.rowHeight = 60
    }
    
    private func setupDelegate() {
        boxOfficeView.delegate = self
        boxOfficeView.searchTextField.delegate = self
    }
    
    private func callRequest(date: String) {
        let key = Bundle.getAPIKey(for: .movie)
        
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BoxOfficeResult.self) { [weak self] response in
                guard let self else { return }
                print(response)
                
                switch response.result {
                case .success(let value):
                    print("Success")
                    dump(value.boxOfficeResult.dailyBoxOfficeList[0])
                    self.dailyBoxOfficeList = value.boxOfficeResult.dailyBoxOfficeList
                    
                case .failure(let error):
                    print("fail", error.localizedDescription)
                }
            }
    }
}

// MARK: - BoxOfficeViewDelegate
extension BoxOfficeViewController: BoxOfficeViewDelegate {
    func tappedSearchButton() {
        if let text = boxOfficeView.searchTextField.text {
            callRequest(date: text)
        }
        boxOfficeView.searchTextField.resignFirstResponder()
        print(#function)
        
    }
}

// MARK: - UITableViewDataSource / UITableViewDelegate
extension BoxOfficeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyBoxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = boxOfficeView.tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.id, for: indexPath) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        print(dailyBoxOfficeList[indexPath.row])
        cell.configure(from: dailyBoxOfficeList[indexPath.row])
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension BoxOfficeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        guard let text = textField.text else { return true }
        callRequest(date: text)
        boxOfficeView.searchTextField.resignFirstResponder()
        return true
    }
}
