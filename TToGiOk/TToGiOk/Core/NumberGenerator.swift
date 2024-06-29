//
//  NumberGenerator.swift
//  TToGiOk
//
//  Created by Ellen J on 6/29/24.
//

import Foundation
import SwiftUI

final class BallGenerator: ObservableObject {
    
    @Published var game: [Int: PowerBall] = [
        0: PowerBall(status: .gathering, _gauge: 90),
        1: PowerBall(status: .gathering, _gauge: 90),
        2: PowerBall(status: .gathering, _gauge: 90),
        3: PowerBall(status: .gathering, _gauge: 90),
        4: PowerBall(status: .gathering, _gauge: 90),
        5: PowerBall(status: .gathering, _gauge: 90)
    ]
    
    static let shared = BallGenerator()
    
    private init() {
        
    }
    
    func getCurrentBall(index: Int) -> PowerBall {
        return game[index] ?? PowerBall(status: .gathering, _gauge: 0)
    }
    
    func getBalls() -> [Int: PowerBall] {
        return game
    }
    
    func fetchBalls(index: Int, ball: PowerBall) -> PowerBall {
        var ball: PowerBall = ball
        game[index] = ball
        
        return game[index] ?? ball
    }
}
