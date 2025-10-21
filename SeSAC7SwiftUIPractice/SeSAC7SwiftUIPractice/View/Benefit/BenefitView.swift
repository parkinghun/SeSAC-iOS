//
//  BenefitView.swift
//  SeSAC7SwiftUIPractice
//
//  Created by 박성훈 on 10/20/25.
//

import SwiftUI

struct BenefitView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                BannerView()
                
                MissionListSection()
            }
        }
        .background(.black)
    }
}

extension BenefitView {
    private struct BannerView: View {
        var body: some View {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "bell.badge.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(.yellow)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("[70,000원] 가입 지원금")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("빛썸 가입하고 미수령 지원금 받기 • AD")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    private struct MissionListSection: View {
        struct Mission: Identifiable {
            let id = UUID()
            let title: String
            let subtitle: String
            let icon: String
            let badge: String?
            let accentColor: Color
        }
        
        let missions: [Mission] = [
            Mission(title: "오늘의 행운복권", subtitle: "포인트 받기", icon: "camera.macro", badge: nil, accentColor: .green),
            Mission(title: "라이브 쇼핑", subtitle: "포인트 받기", icon: "video.fill", badge: nil, accentColor: .red),
            Mission(title: "행운퀴즈", subtitle: "추가 혜택 보기", icon: "q.circle.fill", badge: nil, accentColor: .purple),
            Mission(title: "이번 주 미션", subtitle: "얼마 받을지 보기", icon: "target", badge: nil, accentColor: .pink),
            Mission(title: "두근두근 1등 찍기", subtitle: "포인트 받기", icon: "hand.tap.fill", badge: "새로 나온", accentColor: .blue),
            Mission(title: "일주일 방문 미션", subtitle: "포인트 받기", icon: "star.square.fill", badge: nil, accentColor: .blue),
            Mission(title: "머니 알림", subtitle: "포인트 받기", icon: "bell.fill", badge: nil, accentColor: .yellow),
            Mission(title: "등록한 현금영수증 도착", subtitle: "10원 받기", icon: "receipt.fill", badge: nil, accentColor: .teal),
            Mission(title: "진행중인 이벤트", subtitle: "모아보기", icon: "gift.fill", badge: nil, accentColor: .orange)
        ]
        
        var body: some View {
            VStack(spacing: 0) {
                ForEach(missions) { mission in
                    MissionRow(mission: mission)
                }
            }
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    private struct MissionRow: View {
        let mission: MissionListSection.Mission
        
        var body: some View {
            HStack(spacing: 12) {
                Image(systemName: mission.icon)
                    .foregroundStyle(mission.accentColor)
                    .font(.system(size: 24))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(mission.title)
                        .foregroundStyle(.white)
                    
                    Text(mission.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                }
                Spacer()
                
                if let badge = mission.badge {
                    Text(badge)
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.4))
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    BenefitView()
}
