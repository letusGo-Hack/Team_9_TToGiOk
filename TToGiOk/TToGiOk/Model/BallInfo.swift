//
//  BallInfo.swift
//  TToGiOk
//
//  Created by Ellen J on 6/29/24.
//

import SwiftUI

final class BallInfo {
    let number: Int?
    let color: Color
    
    init(number: Int?) {
        self.number = number
        
        if number == nil {
            self.color = .gray
        } else {
            self.color = BallColor.AllCases().randomElement()?.color ?? .gray
        }
    }
}
