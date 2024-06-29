//
//  TTogiokExtensionLiveActivity.swift
//  TTogiokExtension
//
//  Created by Jihaha kim on 6/29/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TTogiokExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TTogiokExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TTogiokExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TTogiokExtensionAttributes {
    fileprivate static var preview: TTogiokExtensionAttributes {
        TTogiokExtensionAttributes(name: "World")
    }
}

extension TTogiokExtensionAttributes.ContentState {
    fileprivate static var smiley: TTogiokExtensionAttributes.ContentState {
        TTogiokExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TTogiokExtensionAttributes.ContentState {
         TTogiokExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TTogiokExtensionAttributes.preview) {
   TTogiokExtensionLiveActivity()
} contentStates: {
    TTogiokExtensionAttributes.ContentState.smiley
    TTogiokExtensionAttributes.ContentState.starEyes
}
