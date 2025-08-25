//
//  LottoViewModel.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class LottoViewModel: ConfigureViewModelProtocol {
    struct Input {
        let query: ControlProperty<String>
        let checkButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let result: PublishSubject<String>
    }
    
    
    private let baseUrl  = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
    
    var disposeBag = DisposeBag()
    
    init() { }
    
    
    func transform(input: Input) -> Output {
        let resultSubject = PublishSubject<String>()
        
        input.checkButtonTapped
            .withLatestFrom(input.query)
            .withUnretained(self)
            .map { self.baseUrl + $0.1 }
            .flatMap { return self.fetchData(url: $0) }
            .bind { value in
                resultSubject.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(result: resultSubject)
    }
}

private extension LottoViewModel {
    func fetchData(url: String) -> Observable<String> {
        
        return Observable<String>.create { observer in
            
            NetworkManager.shated.callRequest(url: url) { (result: Result<Lotto, NetworkError>) in
                switch result {
                case .success(let lotto):
                    let lottoData = LottoData(lotto: lotto)
                    observer.onNext(lottoData.result)
                    observer.onCompleted()
                    
                case .failure(_):
                    observer.onError(NetworkError.invalid)
                }
            }
            return Disposables.create()
            
        }
    }
}



