//
//  SearchViewModel.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 8/12/25.
//

import Foundation

final class ShoppingSearchViewModel {
    struct Input {
        var searchText: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        private(set) var query: Observable<String?> = Observable(nil)
    }
    
    var input: Input
    var output: Output
    
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
        input = Input()
        output = Output()
        
        input.searchText.lazyBind { value in
            self.validation(input: value)
        }
    }
}

private extension ShoppingSearchViewModel {
    func validation(input: String?) {
        print(#function)
        guard let input else {
            output.query.value = nil
            return
        }
        
        let trimmesText = input.trimmingCharacters(in: .whitespaces)

        guard trimmesText.count >= 2 else {
            output.query.value = nil
            return
        }
        
        output.query.value = trimmesText
    }
}

