//
//  AllView.swift
//  SeSAC7SwiftUIPractice
//
//  Created by 박성훈 on 10/20/25.
//

import SwiftUI

struct AllView: View {
    @State private var riceCount = 0
    @State private var waterCount = 0
    @State private var riceText = ""
    @State private var waterText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("밥알 \(riceCount)개 . 물방울 \(waterCount)개")
            
            CountInputRowView(count: $riceCount, text: $riceText, tfPlaceholder: "밥주세용", btTitle: "밥 먹기")
            CountInputRowView(count: $waterCount, text: $waterText, tfPlaceholder: "물주세용", btTitle: "물 먹기")
        }
    }
}

private struct CountInputRowView: View {
    @Binding var count: Int
    @Binding var text: String
    let tfPlaceholder: String
    let btTitle: String
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 16) {
            CountTextFiedView(text: $text, placeholder: tfPlaceholder)
            CountButton(count: $count, text: $text, title: btTitle)
        }
    }
}

private struct CountTextFiedView: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .multilineTextAlignment(.center)
            Divider()
                .background(.black)
        }
        .frame(width: 180)

    }
}

private struct CountButton: View {
    @Binding var count: Int
    @Binding var text: String
    let title: String
    
    var body: some View {
        Button {
            if text.isEmpty {
                count += 1
            } else if let value = Int(text) {
                count += value
            }
        } label: {
            Text(title)
                .foregroundStyle(.black)
                .padding(8)
                
        }
        .overlay(RoundedRectangle(cornerRadius: 6)
            .stroke(Color.black, lineWidth: 2))
    }
}


#Preview {
    AllView()
}
