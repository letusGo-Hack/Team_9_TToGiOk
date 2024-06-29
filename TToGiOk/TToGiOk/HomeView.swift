//
//  HomeView.swift
//  TToGiOk
//
//  Created by Ellen J on 6/29/24.
//

import SwiftUI

struct HomeView: View {
    @State var balls: [Int: PowerBall] = BallGenerator.shared.getBalls()
    
    var body: some View {
        NavigationStack {
            VStack {
                BallScrollView(balls: $balls)
            }
        }
    }
}

extension HomeView {
    struct BallScrollView: View {
        @Binding var balls: [Int: PowerBall]
        private let ballHeight: CGFloat = 200
        private let space: CGFloat = 20
        var body: some View {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: space) {
                        
                        ForEach(Array(balls.keys), id: \.self) { key in
                            NavigationLink(
                                destination: ShakeView(
                                    ball: balls[key] ?? .init(status: .gathering, _gauge: 85
                                                             ), index: key
                                )
                            ) {
                                ZStack {
                                    Circle()
                                        .fill(balls[key]?.color ?? .gray)
                                        .frame(height: ballHeight)
                                    
                                    Text("\(balls[key]?.number ?? 0)")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                
                NavigationLink(destination: TotalView()) {
                    Text("전체보기")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 60)
                }
                .background(.gray)
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
    }
}
