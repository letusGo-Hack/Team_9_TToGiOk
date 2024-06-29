//
//  TToGiokStatusAttributes.swift
//  TToGiOk
//
//  Created by Jihaha kim on 6/29/24.
//


import Foundation
import ActivityKit
import UIKit

//struct TToGiokStatusAttributes: ActivityAttributes {
//    public typealias TToGiokStatusStatus = ContentState
//
//    public struct ContentState: Codable, Hashable {
//        var dateName: String
//        var dateTimer: ClosedRange<Date>
//    }
//
//    var numberOfggok: Int
//    var totalAmount: String
//    var orderNumber: String
//}
struct TToGiokStatusAttributes: ActivityAttributes {
    // 활동의 유형을 정의하는 프로퍼티
    static let activityType = "TToGiokStatus"

    // 활동의 내용을 정의하는 프로퍼티
    var content: ContentState
    
    struct ContentState: Codable, Hashable {
        var dateName: String
        var dateTimer: ClosedRange<Date>
    }

    var numberOfgiok: Int
    var totalAmount: String
    var orderNumber: String
}
