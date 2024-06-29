//
//  ShakeView.swift
//  CoreMotionDemo
//
//  Created by Hans Yim on 6/29/24.
//
import SwiftUI

struct ShakeView: View {
    
    @StateObject var shakeManager: ShakeManager
    let index: Int
    
    init(ball: PowerBall, index: Int) {
        self.index = index
        _shakeManager = StateObject(wrappedValue: ShakeManager(ball: ball))
    }
    
    var body: some View {
        VStack {
            if let number = shakeManager.ball.number {
                CircleNumberView(number: number, color: .blue)
                
            } else {
                CircleWaveView(
                    percent: shakeManager.ball.gauge,
                    color: .green
                )
            }
            
            HStack {
                Text("Shake is Completed.")
                    .font(.title2)
                
                Circle()
                    .fill(shakeManager.ball.status != .gathering ? Color.green : Color.gray)
                    .frame(width: 20)
            }
            
            Button {
                shakeManager.drawNumber()
                BallGenerator.shared.fetchBalls(index: index, ball: shakeManager.ball)
            } label: {
                Text("번호 뽑아!")
                    .font(.title3)
            }
            .disabled(shakeManager.ball.status == .gathering || shakeManager.ball.status == .drawCompleted)
            
        }
        .padding()
    }
}
