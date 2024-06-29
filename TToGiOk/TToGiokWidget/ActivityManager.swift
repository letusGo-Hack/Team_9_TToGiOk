//
//  ActivityManager.swift
//  TToGiOk
//
//  Created by Jihaha kim on 6/29/24.
//
import Foundation
import ActivityKit

public enum OrderStatus: CaseIterable, Codable, Equatable {
    case received
    case progress
    case ready
    
    var image: String {
        switch self {
        case .received:
            return "circle.fill"
        case .progress:
            return "circle.fill"
        case .ready:
            return "circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .received:
            return "원기옥을 다 모으셨어요!"
        case .progress:
            return "원기옥 모으는중!"
        case .ready:
            return "이번주의 원기옥을 모아보세요!"
        }
    }
    
    var subTitle: String {
        switch self {
        case .received:
            return "원기옥 모음 완료!"
        case .progress:
            return "n요일까지 모으셨네요! 토요일까지 힘내서 당첨되봐요!"
        case .ready:
            return "원기옥을 모아보아요!"
        }
    }
}


struct OrderAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var status: OrderStatus = .received
    }
    
    var orderNumber: Int
    var orderItems: [String]
}


public class OrderActivityManager {
    private init() {}
    
    public static func status(id: String) -> OrderStatus? {
        guard let activity = Activity<OrderAttributes>.activities.first(where: { $0.id == id }) else {
            return nil
        }
        
        return activity.contentState.status
    }
    
    public static func endLiveActivity(id: String) {
        guard let activity = Activity<OrderAttributes>.activities.first(where: { $0.id == id }) else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            Task {
                await activity.end(using: activity.contentState, dismissalPolicy: .immediate)
            }
        }
    }
    
    public static func updateLiveActivity(id: String, updatedStatus: OrderStatus) {
        guard let activity = Activity<OrderAttributes>.activities.first(where: { $0.id == id }) else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            var updatedState = activity.contentState
            updatedState.status = updatedStatus
            
            Task {
                await activity.update(using: updatedState)
            }
        }
    }
    
    public static func addLiveActivity() -> String? {
        let orderAttributes = OrderAttributes(orderNumber: 123, orderItems: ["circle.fill", "circle.fill"])
        let initialContentState = OrderAttributes.ContentState()
        
        do {
            let activity = try Activity<OrderAttributes>.request(attributes: orderAttributes,
                                                                 contentState: initialContentState,
                                                                 pushType: nil)
            
            print("Request a Live Activity \(String(describing: activity.id)).")
            
            return activity.id
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
}

