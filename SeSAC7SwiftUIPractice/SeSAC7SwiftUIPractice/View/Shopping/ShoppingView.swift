//
//  ShoppingView.swift
//  SeSAC7SwiftUIPractice
//
//  Created by 박성훈 on 10/20/25.
//

import SwiftUI

struct ImageSection: Identifiable {
    let id = UUID()
    let title: String
    let imageURLs: [String]
}

struct ShoppingView: View {
    let sections: [ImageSection] = [
        ImageSection(title: "첫번째 섹션", imageURLs: Array(repeating: "https://picsum.photos/200", count: 5)),
        ImageSection(title: "두번째 섹션", imageURLs: Array(repeating: "https://picsum.photos/200", count: 5)),
        ImageSection(title: "세번째 섹션", imageURLs: Array(repeating: "https://picsum.photos/200", count: 5)),
        ImageSection(title: "네번째 섹션", imageURLs: Array(repeating: "https://picsum.photos/200", count: 5))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(sections) { section in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(section.title)
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(section.imageURLs, id: \.self) { urlString in
                                        AsyncImage(url: URL(string: urlString))
                                            .frame(width: 120, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("My Random Image")
        }
    }
}

#Preview {
    NavigationStack {
        ShoppingView()
    }
}
