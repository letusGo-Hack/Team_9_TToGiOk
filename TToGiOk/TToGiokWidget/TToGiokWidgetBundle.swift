//
//  TToGiokWidgetBundle.swift
//  TToGiokWidget
//
//  Created by Ellen J on 6/29/24.
//

import WidgetKit
import SwiftUI

@main
struct TToGiokWidgetBundle: WidgetBundle {
    var body: some Widget {
        TToGiokStaticWidget()
        TToGiokLiveActivityWidget()
    }
}
