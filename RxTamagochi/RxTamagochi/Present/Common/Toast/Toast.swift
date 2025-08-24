//
//  Toast.swift
//  RxTamagochi
//
//  Created by 박성훈 on 8/24/25.
//

import UIKit

struct Toast: Equatable {
    let status: ToastStatus
    let message: String
}

enum ToastStatus {
    case check, warning
    
    var icon: UIImage? {
        switch self {
        case .check:
            return UIImage(systemName: "checkmark.circle.fill")
            
        case .warning:
            return UIImage(systemName: "exclamationmark.circle.fill")
        }
    }
}
