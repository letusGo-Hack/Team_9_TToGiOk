//
//  GoPraying.swift
//  TToGiOk
//
//  Created by Kim Yewon on 6/29/24.
//

import AppIntents

struct NavToShakeIntent: AppIntent {
    
    static var title: LocalizedStringResource = "정성 들이기"
    static var description = IntentDescription("정성을 들이러가용")
    static var openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        /// Return an empty result, indicating that the intent is complete.
        NotificationCenter.default.post(name: .navToShake, object: nil)
        return .result()
    }
}

extension Notification.Name {
    static let navToShake = Notification.Name("navToShake")
}
