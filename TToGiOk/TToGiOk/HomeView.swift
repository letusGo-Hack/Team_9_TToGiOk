//
//  HomeView.swift
//  TToGiOk
//
//  Created by Ellen J on 6/29/24.
//

import SwiftUI

struct HomeView: View {
    
    private let colors: [BallColor] = BallColor.allCases
    
    @State private var scrollPosition: Int?
    @State private var itemsArray: [[BallColor]] = []
    @State private var autoScrollEnabled: Bool = false
    private let pageWidth: CGFloat = 250
    private let pageHeight: CGFloat = 250
    private let animationDuration: CGFloat = 0.3
    private let secondsPerSlide: CGFloat = 1.0
    private let animation: Animation = .default
    @State var currentActivityID: String = ""
    @State var currentActivityStatus: OrderStatus = .received
    @State var activityIDs: [String] = []
    @StateObject private var appLifecycleHandler = AppLifecycleHandler()

    var body: some View {
        let itemsTemp = itemsArray.flatMap { $0.map { $0 } }
        let widthDifference = UIScreen.main.bounds.width - pageWidth
        
        VStack(spacing: 20) {
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(0..<itemsTemp.count, id: \.self) { index in
                        let item = itemsTemp[index]
                        
                        Text(item.rawValue)
                            .foregroundStyle(.black)
                            .font(.system(size: 24, weight: .bold))
                            .frame(width: pageWidth, height: (index == scrollPosition) ? pageHeight * 1.2 : pageHeight)
                            .background(
                                Circle()
                                    .fill(item.color)
                                
                            )
                            .padding(.horizontal, (widthDifference)/2)
                            .offset(x: (index == scrollPosition) ? 0 : (index < scrollPosition ?? colors.count) ? widthDifference*0.75 : -widthDifference*0.75)
                        
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: pageHeight * 1.3)
            .scrollPosition(id: $scrollPosition, anchor: .center)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .onAppear {
                self.itemsArray = [colors, colors, colors]
                // start at the first item of the second colors array
                scrollPosition = colors.count
            }
            .onChange(of: scrollPosition) {
                guard let scrollPosition = scrollPosition else {return}
                
                let itemCount = colors.count
                // last item of the first colors Array
                if scrollPosition / itemCount == 0 && scrollPosition % itemCount == itemCount - 1  {
                    print("last item of the first colors")
                    // append colors array before the first and remove the curren last color array
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        itemsArray.removeLast()
                        itemsArray.insert(colors, at: 0)
                        self.scrollPosition = scrollPosition + colors.count
                    }
                    return
                }
                
                // first item of the last colors Array
                if scrollPosition / itemCount == 2 && scrollPosition % itemCount == 0  {
                    print("first item of the last colors")
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        itemsArray.removeFirst()
                        itemsArray.append(colors)
                        self.scrollPosition = scrollPosition - colors.count
                    }
                    
                    return
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + secondsPerSlide, execute: {
                    if autoScrollEnabled {
                        withAnimation(animation) {
                            self.scrollPosition = scrollPosition + 1
                        }
                    }
                })
            }
            .onChange(of: appLifecycleHandler.isAppActive) { isActive in
                if isActive {
                    guard let currentActivityID = OrderActivityManager.addLiveActivity() else {
                        return
                    }
                    
                    self.currentActivityID = currentActivityID
                    self.activityIDs.append(currentActivityID)
                } else {
                    guard let currentActivityID = OrderActivityManager.addLiveActivity() else {
                        return
                    }
                    
                    self.currentActivityID = currentActivityID
                    self.activityIDs.append(currentActivityID)
                }
            }
            
            HStack {
                ForEach(0..<colors.count, id: \.self) { index in
                    Button(action: {
                        withAnimation(animation) {
                            scrollPosition = index + colors.count
                        }
                    }, label: {
                        Circle()
                            .fill(Color.gray.opacity(
                                (index == (scrollPosition ?? 0) % colors.count) ? 0.8 : 0.3
                            ))
                            .frame(width: 15)
                    })
                }
            }
            
            Spacer()
                .frame(height: 30)
            
            Button {
                print("화면이동")
            } label: {
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
