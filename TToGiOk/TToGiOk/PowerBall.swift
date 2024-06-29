//
//  Power.swift
//  CoreMotionDemo
//
//  Created by Hans Yim on 6/29/24.
//
import Foundation
import SwiftUI

struct PowerBall: Equatable, Identifiable {
    let id = UUID()
    let color: Color
    var number: Int?
    var status: BallDrawStage = .gathering
    
    private var _gauge: Int = 90 // 
    var gauge: Int {
        get {
            return _gauge
        }
        set {
            if newValue < 0 {
                _gauge = 0
            } else if newValue == 100 {
                _gauge = 100
                status = .gatheringCompleted
                
            } else if newValue > 100 {
                return
            } else {
                _gauge = newValue
            }
        }
    }
    
    init(number: Int? = nil, status: BallDrawStage, _gauge: Int) {
        self.number = number
        self.status = status
        self._gauge = _gauge
        
        if number == nil {
            self.color = .gray
        } else {
            self.color = BallColor.allCases.randomElement()?.color ?? .gray
        }
    }
    
    mutating func getNumber() {
        let numbers: Int = 45
        number = Int.random(in: 1...numbers)
        status = .drawCompleted
    }
}

extension PowerBall {
    enum BallDrawStage {
        case gathering
        case gatheringCompleted
        case drawCompleted
    }
}
