//
//  OpenTGO.swift
//  TToGiOk
//
//  Created by Kim Yewon on 6/29/24.
//

import AppIntents

struct NavMainIntent: AppIntent {
    
    static var title: LocalizedStringResource = "또기옥 열기"
    static var description = IntentDescription("정성을 들이러가용")
    static var openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        /// Return an empty result, indicating that the intent is complete.
        return .result()
    }
    
}
