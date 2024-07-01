//
//  ActivityLifeCycleHandler.swift
//  TToGiOk
//
//  Created by Jihaha kim on 7/1/24.
//

import SwiftUI
import Combine

class AppLifecycleHandler: ObservableObject {
    @Published var isAppActive: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let willEnterForeground = NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
        let didEnterBackground = NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
        
        willEnterForeground
            .sink { [weak self] _ in
                self?.isAppActive = true
                self?.appDidBecomeActive()
            }
            .store(in: &cancellables)
        
        didEnterBackground
            .sink { [weak self] _ in
                self?.isAppActive = false
                self?.appDidEnterBackground()
            }
            .store(in: &cancellables)
    }
    
    private func appDidBecomeActive() {
        print("App did become active")
        // Add your logic here, e.g., start a live activity
    }
    
    private func appDidEnterBackground() {
        print("App did enter background")
        // Add your logic here, e.g., end a live activity
    }
}
