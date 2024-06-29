//
//  ShakeView+Extension.swift
//  CoreMotionDemo
//
//  Created by Hans Yim on 6/29/24.
//
import SwiftUI

extension ShakeView {
    struct CircleNumberView: View {
        @Environment(\.colorScheme) var colorScheme
        let number: Int
        let color: Color
        var body: some View {
            GeometryReader { geo in
                ZStack {
                    
                    Circle()
                        .fill(color)
                    
                    Text("\(number)")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(Font.system(size: 0.25 * min(geo.size.width, geo.size.height) ))
                }
            }
            .aspectRatio(1, contentMode: .fit)
        }
    }
    struct CircleWaveView: View {
        @Environment(\.colorScheme) var colorScheme
        @State private var waveOffset = Angle(degrees: 0)
        let percent: Int
        let color: Color
        var body: some View {

            GeometryReader { geo in
                ZStack {
                    
                    Circle()
                        .stroke(colorScheme == .dark ? .white : .black, lineWidth: 0.025 * min(geo.size.width, geo.size.height))
                        .overlay(
                            Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                                .fill(color)
                                .clipShape(Circle().scale(0.95))
                        )
                    Text("\(self.percent)%")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(Font.system(size: 0.25 * min(geo.size.width, geo.size.height) ))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
                }
            }
        }
    }
    struct Wave: Shape {
        var offset: Angle
        var percent: Double
        
        var animatableData: Double {
            get { offset.degrees }
            set { offset = Angle(degrees: newValue) }
        }
        
        func path(in rect: CGRect) -> Path {
            var p = Path()

            // 파동이 0%와 100%에서 보이도록 결정된 요소 값
            let lowfudge = 0.02
            let highfudge = 0.98
            
            let newpercent = lowfudge + (highfudge - lowfudge) * percent
            let waveHeight = 0.015 * rect.height
            let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
            let startAngle = offset
            let endAngle = offset + Angle(degrees: 360)
            
            p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))
            
            for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
                let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
                p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
            }
            
            p.addLine(to: CGPoint(x: rect.width, y: rect.height))
            p.addLine(to: CGPoint(x: 0, y: rect.height))
            p.closeSubpath()
            
            return p
        }
    }

}
