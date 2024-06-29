//
//  ContentView.swift
//  CoreMotionDemo
//
//  Created by Hans Yim on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            let ball = PowerBall()
            ShakeView(ball: ball)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
