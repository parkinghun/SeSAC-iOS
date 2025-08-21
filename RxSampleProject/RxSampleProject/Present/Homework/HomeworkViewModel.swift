//
//  HomeworkViewModel.swift
//  RxSampleProject
//
//  Created by 박성훈 on 8/21/25.
//

import RxSwift
import RxCocoa

final class HomeworkViewModel {
    struct Input {
        let tableCellModelSelected: ControlEvent<Person>
        let collectionCellModelSelected: ControlEvent<Person>
        let searchButtonClicked: ControlEvent<Void>
        let searchBarText: ControlProperty<String>
    }
    
    struct Output {
        let users: BehaviorRelay<[Person]>
        let selectedUsers: BehaviorRelay<[Person]>
    }
    
    private let disposeBag = DisposeBag()
    private var sampleUsers = Person.sampleUsers

    
    init() { }
    
    func transform(input: Input) -> Output {
        let users = BehaviorRelay(value: sampleUsers)
        let selectedUsers = BehaviorRelay<[Person]>(value: [])
        
        input.tableCellModelSelected
            .bind(with: self) { owner, value in
                var temp = selectedUsers.value.filter { $0 != value }
                temp.insert(value, at: 0)
                
                selectedUsers.accept(temp)
            }
            .disposed(by: disposeBag)
        
        input.collectionCellModelSelected
            .bind(with: self) { owner, value in
                var temp = selectedUsers.value
                temp.removeAll { $0 == value }
                
                selectedUsers.accept(temp)
            }
            .disposed(by: disposeBag)
        
        input.searchButtonClicked
            .withLatestFrom(input.searchBarText)
            .bind(with: self) { owner, value in
                let newUser = Person(name: value)
                var temp = users.value
                temp.insert(newUser, at: 0)
                
                users.accept(temp)
            }
            .disposed(by: disposeBag)
        
        return Output(users: users, selectedUsers: selectedUsers)
    }
}

