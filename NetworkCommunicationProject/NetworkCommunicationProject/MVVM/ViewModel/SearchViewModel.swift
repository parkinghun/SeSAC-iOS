//
//  SearchViewModel.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 8/12/25.
//

import Foundation

final class SearchViewModel {

    var inputSearchText: Observable<String?> = Observable(nil)
    private(set) var outputQuery: Observable<String?> = Observable(nil)

    var title: String {
        return "영캠러의 쇼핑쇼핑"
    }
    var alertTitle: String {
        return "입력 글자수 부족"
    }
    var alertMessage: String {
        return "검색어는 두 글자 이상 입력해주세요."
    }
    
    init() {
        inputSearchText.lazyBind { value in
            self.validation(input: value)
        }
    }
}

private extension SearchViewModel {
    func validation(input: String?) {
        print(#function)
        guard let input else {
            outputQuery.value = nil
            return
        }
        
        let trimmesText = input.trimmingCharacters(in: .whitespaces)

        guard trimmesText.count >= 2 else {
            outputQuery.value = nil
            return
        }
        
        outputQuery.value = trimmesText
    }
}

