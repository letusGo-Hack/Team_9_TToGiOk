//
//  TToGiokWidget.swift
//  TToGiokWidget
//
//  Created by Jihaha kim on 7/1/24.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct TToGiokLiveActivityWidget: Widget {
    let kind: String = "TToGiokLiveActivityWidget"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderAttributes.self) { context in
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    HStack(spacing: -8) {
                        ForEach(context.attributes.orderItems, id: \.self) { item in
                            Image(systemName: item)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .foregroundColor(.purple)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("#\(context.attributes.orderNumber)")
                        .foregroundColor(.white)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text(context.state.status.title)
                            .font(.title)
                        
                        Text("\(context.state.status.subTitle)")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        Gradient.Stop(color: context.state.status == .received ? .white.opacity(0.6) : .purple, location: 0.5),
                                        Gradient.Stop(color: context.state.status == .ready ? .purple : .white.opacity(0.6), location: 0.5)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing)
                            )
                            .frame(height: 2)
                            .padding(.horizontal, 60)
                        
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(OrderStatus.allCases, id: \.self) { status in
                                Image(systemName: status.image)
                                    .font(context.state.status == status ? .title2 : .body)
                                    .foregroundColor(context.state.status == status ? .purple : Color.init(red: 0.6, green: 0.6, blue: 0.6))
                                    .frame(width: context.state.status == status ? 45 : 32, height: context.state.status == status ? 45 : 32)
                                    .background {
                                        Circle()
                                            .fill(context.state.status == status ? .white : Color.init(red: 0.4, green: 0, blue: 0.4))
                                    }
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
            } compactLeading: {
                HStack(spacing: -8) {
                    ForEach(context.attributes.orderItems, id: \.self) { item in
                        Image(systemName: item)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                }
                .foregroundColor(.purple)
            } compactTrailing: {
                Image(systemName: context.state.status.image)
                    .font(.title3)
            } minimal: {
                Image(systemName: context.state.status.image)
                    .font(.title3)
            }
            .keylineTint(Color.purple)
        }
    }
}

struct TToGiokStaticWidget: Widget {
    let kind: String = "TToGiokStaticWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14.0, iOS 17.0, *) {
                TToGiokWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TToGiokWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<OrderAttributes>
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15,
                             style: .continuous)
            .fill(Color.black.gradient)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(context.state.status.title)")
                            .font(.title3)
                            .foregroundColor(.white)
                        Text(context.state.status.subTitle)
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    
                    Spacer()
                    
                    HStack(spacing: -8) {
                        ForEach(context.attributes.orderItems, id: \.self) { item in
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .padding(-2)
                                
                                Circle()
                                    .stroke(.purple, lineWidth: 1.5)
                                    .padding(-2)
                                
                                Image(systemName: item)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.purple)
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                }
                
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    Gradient.Stop(color: context.state.status == .received ? .white.opacity(0.6) : .purple, location: 0.5),
                                    Gradient.Stop(color: context.state.status == .ready ? .purple : .white.opacity(0.6), location: 0.5)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                        .frame(height: 2)
                        .offset(y: 12)
                        .padding(.horizontal, 60)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        ForEach(OrderStatus.allCases, id: \.self) { status in
                            Image(systemName: status.image)
                                .font(context.state.status == status ? .title2 : .body)
                                .foregroundColor(context.state.status == status ? .purple : .white.opacity(0.6))
                                .frame(width: context.state.status == status ? 45 : 32, height: context.state.status == status ? 45 : 32)
                                .background {
                                    Circle()
                                        .fill(context.state.status == status ? .white : .purple.opacity(0.4))
                                }
                                .background(alignment: .bottom, content: {
                                    BottomArrow(status: context.state.status, type: status)
                                })
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func BottomArrow(status: OrderStatus, type: OrderStatus) -> some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 15))
            .scaleEffect(x: 1.3)
            .offset(y: 6)
            .opacity(status == type ? 1 : 0)
            .foregroundColor(.white)
            .overlay(alignment: .bottom) {
                Circle()
                    .fill(.white)
                    .frame(width: 5, height: 5)
                    .offset(y: 13)
            }
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    //    func relevances() async -> WidgetRelevances<Void> {
    //        // Generate a list containing the contexts this widget is relevant in.
    //    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct TToGiokWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            HStack {
                Text("Time:")
                Text(entry.date, style: .time)
            }
            
            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}
