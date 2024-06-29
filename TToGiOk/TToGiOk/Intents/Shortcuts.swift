//
//  Shortcuts.swift
//  TToGiOk
//
//  Created by Kim Yewon on 6/29/24.
//

import AppIntents

struct TToGiOkShortCuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: NavMainIntent(),
            phrases: [
                "\(.applicationName) 열기",
            ],
            shortTitle: "또기옥 열기",
            systemImageName: "shoeprints.fill"
        )
        
        AppShortcut(
            intent: NavToResultIntent(),
            phrases: [
                "\(.applicationName) 에서 결과 보러 가기",
                "\(.applicationName) 에 로또 보러 가기"
            ],
            shortTitle: "결과 열기",
            systemImageName: "hand.point.up.left.and.text"
        )
        
        AppShortcut(
            intent: NavToShakeIntent(),
            phrases: [
                "\(.applicationName) 에 기도하러 가기",
                "\(.applicationName) 에 정성 들이러 가기"
            ],
            shortTitle: "기도하러 가기",
            systemImageName: "hands.and.sparkles"
        )
    }
}

