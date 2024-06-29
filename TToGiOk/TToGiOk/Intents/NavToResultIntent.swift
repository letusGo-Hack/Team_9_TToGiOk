//
//  GoResult.swift
//  TToGiOk
//
//  Created by Kim Yewon on 6/29/24.
//

import AppIntents

struct NavToResultIntent: AppIntent {
    
    static var title: LocalizedStringResource = "결과 보기"
    static var description = IntentDescription("정성을 들이러가용")
    static var openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        /// Return an empty result, indicating that the intent is complete.
        NotificationCenter.default.post(name: .navToResults, object: nil)
        return .result()
    }
    
}

extension Notification.Name {
    static let navToResults = Notification.Name("navToResults")
}

