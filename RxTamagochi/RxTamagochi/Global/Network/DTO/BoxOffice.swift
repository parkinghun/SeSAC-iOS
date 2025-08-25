//
//  Boxoffice.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/26/25.
//

import Foundation

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: BoxOfficeList
}

// MARK: - BoxOfficeResult
struct BoxOfficeList: Decodable {
    let dailyBoxOfficeList: [DailyBoxOffice]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOffice: Decodable {
    let movieNm: String
}
