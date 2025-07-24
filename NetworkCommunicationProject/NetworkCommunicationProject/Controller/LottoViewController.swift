//
//  ViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit
import Alamofire

final class LottoViewController: UIViewController {
    
    private let lottoView = LottoView()
    private var recentRound = 1181
    
    private var roundList: [Int] {
        return Array(1...recentRound).reversed()
    }
    
    override func loadView() {
        self.view = lottoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegation()
        callRequest(round: recentRound)
    }
    
    private func configureDelegation() {
        lottoView.configureDelegation(self)
        lottoView.roundPickerView.delegate = self
        lottoView.roundPickerView.dataSource = self
    }
    
    private func callRequest(round: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        
        AF.request(url, method: .get)
            .responseDecodable(of: Lotto.self) { [weak self] response in
                guard let self else { return }
                print(response)
                switch response.result {
                case .success(let lotto):
                    print(lotto)
                    let lottoBalls = getNumbers(from: lotto)
                    self.lottoView.configure(row: lottoBalls, round: round, date: lotto.drwNoDate)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    private func getNumbers(from lotto: Lotto) -> [LottoBall] {
        let numberArray = [lotto.drwtNo1, lotto.drwtNo2, lotto.drwtNo3, lotto.drwtNo4, lotto.drwtNo5, lotto.drwtNo6, lotto.bnusNo]
        
        return numberArray.map { LottoBall(number: $0) }
    }
}

// MARK: - LottoViewDelegate
extension LottoViewController: LottoViewDelegate {
    func tappedView() {
        print(#function)
        lottoView.searchTextField.resignFirstResponder()
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roundList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(roundList[row]) 회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callRequest(round: roundList[row])
    }
}
