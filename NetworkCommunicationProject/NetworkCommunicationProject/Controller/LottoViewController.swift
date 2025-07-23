//
//  ViewController.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

final class LottoViewController: UIViewController {

    let lottoView = LottoView()
    private let lottoManager = LottoManager()
    private var lottoNumbers: [LottoNumber] = []
    private var selectedRound = 0
    
    override func loadView() {
        self.view = lottoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegation()
    }
    
    private func configureDelegation() {
        lottoView.configureDelegation(self)
        lottoView.roundPickerView.delegate = self
        lottoView.roundPickerView.dataSource = self
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottoManager.rounds.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(lottoManager.rounds[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateSelectedRound(with: lottoManager.rounds[row])
        updateLottoResult()
    }
    
    private func updateSelectedRound(with row: Int) {
        selectedRound = lottoManager.rounds[row - 1]
    }
    
    private func updateLottoResult() {
        lottoNumbers = lottoManager.generateNumbers()
        lottoView.configure(row: lottoNumbers, round: selectedRound)
    }
}

extension LottoViewController: LottoViewDelegate {
    func tappedView() {
        print(#function)
        lottoView.searchTextField.resignFirstResponder()
    }
}
