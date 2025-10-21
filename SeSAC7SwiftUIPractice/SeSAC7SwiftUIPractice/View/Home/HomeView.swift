//
//  HomeView.swift
//  SeSAC7SwiftUIPractice
//
//  Created by 박성훈 on 10/20/25.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

struct StockItem: Identifiable {
    let id = UUID()
    let title: String
    let price: Double
    let changePercent: Double
    let isUp: Bool
}

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CategorySection()
                
                StockSection()
                
                GridSection()
                
                MenuListSection()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
        .background(.black)
        
    }
}

extension HomeView {
    struct CategorySection: View {
        private let categories: [Item] = [Item(title: "국내주식", image: "wonsign.circle"),
                                          Item(title: "해외주식", image: "dollarsign.circle"),
                                          Item(title: "채권", image: "lirasign.square.fill"),
                                          Item(title: "ETF", image: "bahtsign.gauge.chart.lefthalf.righthalf")]
        
        var body: some View {
            HStack(spacing: 12) {
                ForEach(categories) { item in
                    VStack(spacing: 8) {
                        Image(systemName: item.image)
                            .font(.system(size: 28))
                        Text(item.title)
                            .font(.caption)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .buttonWrapper {
                        print("category \(item.title) tapped")
                    }
                }
            }
        }
    }
    
    struct StockSection: View {
        private let stocks: [StockItem] = [
            StockItem(title: "코스닥", price: 695.59, changePercent: 2.0, isUp: true),
            StockItem(title: "나스닥", price: 16724.46, changePercent: 2.0, isUp: true),
            StockItem(title: "S&P500", price: 5200.42, changePercent: -1.2, isUp: false),
            StockItem(title: "코스닥", price: 695.59, changePercent: 2.0, isUp: false),
            StockItem(title: "나스닥", price: 16724.46, changePercent: 2.0, isUp: true),
            StockItem(title: "S&P500", price: 5200.42, changePercent: -1.2, isUp: false)
        ]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(stocks) { stock in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(stock.title)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                HStack(spacing: 4) {
                                    Text(String(format: "%.2f", stock.price))
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(String(format: "%@%.1f%%", stock.isUp ? "+" : "", stock.changePercent))
                                        .font(.subheadline)
                                        .foregroundStyle(stock.isUp ? .red : .blue)
                                }
                            }
                            
                            Divider()
                                .frame(width: 1, height: 22)
                                .background(.gray)
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
            .frame(height: 60)
        }
    }
    
    struct GridSection: View {
        private let gridItems: [Item] = [Item(title: "숨은 환급액 찾기", image: "bag.circle.fill"),
                                         Item(title: "혜택 받는 신용카드", image: "creditcard.fill")]
        
        var body: some View {
            HStack(spacing: 12) {
                ForEach(gridItems) { item in
                    HStack {
                        Text(item.title)
                            .font(.headline)
                        Image(systemName: item.image)
                            .font(.largeTitle)
                            .opacity(0.8)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .buttonWrapper {
                        print("Grid - \(item.title) tapped")
                    }
                }
            }
        }
    }
    
    struct MenuListSection: View {
        private let menus: [Item] = [Item(title: "내 현금영수증", image: "doc.text.fill"),
                                     Item(title: "내 보험료 점검하기", image: "stethoscope.circle.fill"),
                                     Item(title: "더 낸 연말정산 돌려받기", image: "calendar")]
        
        
        var body: some View {
            VStack(spacing: 0) {
                ForEach(menus) { menu in
                    HStack {
                        Image(systemName: menu.image)
                            .frame(width: 24)
                        Text(menu.title)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color(.secondarySystemBackground).opacity(0.2))
                    .buttonWrapper {
                        print("List - \(menu.title) Navigation 이동")
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    HomeView()
}
