//
//  SecuritiesView.swift
//  SeSAC7SwiftUIPractice
//
//  Created by 박성훈 on 10/20/25.
//

import SwiftUI

struct SecuritiesView: View {
    @State private var selectedTab = 0
    private let tabs = ["모두", "국내", "해외"]
    private let cityList = CityInfo().city
    
    let rows = Array(repeating: GridItem(.fixed(120), spacing: 12), count: 2)
    
    var filteredCities: [City] {
        switch selectedTab {
        case 1:
            return cityList.filter { $0.domesticTravel }
        case 2:
            return cityList.filter { !$0.domesticTravel }
        default:
            return cityList
        }
    }
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 22) {
                Divider()
                VStack {
                    CategoryPickerView(tabs: tabs, selectedTab: $selectedTab)
                    
                    ScrollView {
                        LazyVGrid(columns: GridLayout.columns, spacing: 16) {
                            ForEach(filteredCities) { city in
                                CityInfoView(city: city)
                                    .frame(height: 220)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .padding(.horizontal, 16)
                .navigationTitle("인기도시")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .background(.white)
    }
}

private extension SecuritiesView {
    enum GridLayout {
        static let columns = [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ]
    }
}

struct CityInfoView: View {
    let city: City
    
    var body: some View {
        VStack() {
            AsyncImage(url: URL(string: city.cityImage)) { image in
                image
                    .resizable()
//                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .clipShape(Circle())
            
            Spacer()
                .frame(height: 8)
            
            Text(city.nameLabelText)
            Text(city.cityExplain)
                .multilineTextAlignment(.center)
        }
    }
}

private struct CategoryPickerView: View {
    let tabs: [String]
    @Binding var selectedTab: Int
    
    var body: some View {
        Picker("카테고리", selection: $selectedTab) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Text(tabs[index])
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    NavigationStack {
        SecuritiesView()
    }
}
