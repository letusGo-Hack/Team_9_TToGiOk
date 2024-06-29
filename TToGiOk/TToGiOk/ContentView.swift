//
//  ContentView.swift
//  TToGiOk
//
//  Created by Ellen J on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    @State var currentActivityID: String = ""
    @State var currentActivityStatus: OrderStatus = .received
    @State var activityIDs: [String] = []
    @StateObject private var appLifecycleHandler = AppLifecycleHandler()

    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
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
    }
}

#Preview {
    ContentView()
}
