//
//  TabView.swift
//  SeSAC7SwiftUIPractice
//
//  Created by 박성훈 on 10/20/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("홈", systemImage: "house", value: 0) {
                HomeView()
            }
            
            Tab("혜택", systemImage: "gift.fill", value: 1) {
                BenefitView()
            }
            
            Tab("토스쇼핑", systemImage: "bag.fill", value: 2) {
                ShoppingView()
            }
            
            Tab("증권", systemImage: "bahtsign.arrow.trianglehead.counterclockwise.rotate.90", value: 3) {
                SecuritiesView()
            }
            
            Tab("전체", systemImage: "text.justify", value: 4) {
                AllView()
            }
        }
        .tint(.white)
        
    }
}

#Preview {
    MainTabView()
}
