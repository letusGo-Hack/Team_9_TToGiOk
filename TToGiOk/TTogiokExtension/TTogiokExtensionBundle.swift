//
//  TTogiokExtensionBundle.swift
//  TTogiokExtension
//
//  Created by Jihaha kim on 6/29/24.
//

import WidgetKit
import SwiftUI

@main
struct TTogiokExtensionBundle: WidgetBundle {
    var body: some Widget {
        TTogiokExtension()
        TTogiokExtensionControl()
        TTogiokExtensionLiveActivity()
    }
}
