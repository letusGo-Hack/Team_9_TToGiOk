//
//  TToGiokWidgetBundle.swift
//  TToGiokWidget
//
//  Created by Jihaha kim on 7/1/24.
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
