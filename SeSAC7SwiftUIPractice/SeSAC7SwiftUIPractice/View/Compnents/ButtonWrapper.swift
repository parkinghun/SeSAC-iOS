//
//  ButtonWrapper.swift
//  SeSAC7SwiftUIPractice
//
//  Created by 박성훈 on 10/22/25.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(action: action) {
            content
        }
    }
}

extension View {
    func buttonWrapper(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
}
