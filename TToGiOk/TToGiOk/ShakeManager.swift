//
//  ShakeManager.swift
//  CoreMotionDemo
//
//  Created by Hans Yim on 6/29/24.
//

import CoreMotion
import Combine

final class ShakeManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private var timer: Timer?
    private let threshold = 1.2 // 흔들림 감지 임계값 (조정 가능)
    
    @Published var ball: PowerBall

    init(ball: PowerBall) {
        self.ball = ball
        startMotionDetection()
    }

    deinit {
        stopMotionDetection()
    }
    
    func drawNumber() {
        ball.getNumber()
    }

    private func startMotionDetection() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1 // 업데이트 간격 조정 (초 단위)
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                if let acceleration = data?.acceleration {
                    self?.handleAcceleration(acceleration)
                }
            }
        }
    }

    private func stopMotionDetection() {
        motionManager.stopAccelerometerUpdates()
    }

    private func handleAcceleration(_ acceleration: CMAcceleration) {
        guard ball.gauge >= 0, ball.gauge < 100 else { return }
        if abs(acceleration.x) >= threshold || abs(acceleration.y) >= threshold || abs(acceleration.z) >= threshold {
            ball.gauge += 1
            print("count: \(ball.gauge)")
        }
    }
}
