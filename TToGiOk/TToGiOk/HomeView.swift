//
//  HomeView.swift
//  TToGiOk
//
//  Created by Ellen J on 6/29/24.
//

import SwiftUI

struct HomeView: View {
    private let balls: [PowerBall] = [
        PowerBall(),
        PowerBall(),
        PowerBall(),
        PowerBall(),
        PowerBall(),
        PowerBall()
    ]
    var body: some View {
        NavigationStack {
            VStack {
                BallScrollView(balls: balls)
            }

        }

    }
}

extension HomeView {
    struct BallScrollView: View {
        let balls: [PowerBall]
        private let ballHeight: CGFloat = 200
        private let space: CGFloat = 20
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: space) {
                    ForEach(balls) { ball in
                        NavigationLink(destination: ShakeView(ball: ball)) {
                            Circle()
                                .fill(ball.color)
                                .frame(height: ballHeight)
                        }
                    }
                }
            }
        }
    }
}
