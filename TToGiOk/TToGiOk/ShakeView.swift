//
//  ShakeView.swift
//  CoreMotionDemo
//
//  Created by Hans Yim on 6/29/24.
//
import SwiftUI

struct ShakeView: View {
    
    @StateObject var shakeManager: ShakeManager
    
    init(ball: PowerBall) {
        _shakeManager = StateObject(wrappedValue: ShakeManager(ball: ball))
    }
    
    var body: some View {
        VStack {
            
            if let number = shakeManager.ball.number {
                CircleNumberView(number: number, color: shakeManager.ball.color)
                
            } else {
                CircleWaveView(
                    percent: shakeManager.ball.gauge,
                    color: shakeManager.ball.color
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
            } label: {
                Text("번호 뽑아!")
                    .font(.title3)
            }
            .disabled(shakeManager.ball.status == .gathering || shakeManager.ball.status == .drawCompleted)
            
        }
        .padding()
    }
}
#Preview {
    let ball = PowerBall()
    ShakeView(ball: ball)
}
