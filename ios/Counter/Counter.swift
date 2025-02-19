//
//  Counter.swift
//  Counter
//
//  Created by zhongwu on 2025/2/18.
//

import SwiftUI
import WidgetKit

struct CounterProvider: TimelineProvider {
    func placeholder(in _: Context) -> CounterEntry {
        CounterEntry(date: Date(), count: getCount())
    }

    func getSnapshot(
        in _: Context,
        completion: @escaping (CounterEntry) -> Void
    ) {
        completion(CounterEntry(date: Date(), count: getCount()))
    }

    func getCount() -> Int64 {
        return CounterManager.shared.counter
    }

    func getTimeline(
        in _: Context,
        completion: @escaping (Timeline<CounterEntry>) -> Void
    ) {
        var entries: [CounterEntry] = []
        let entry = CounterEntry(
            date: Date(),
            count: getCount()
        )
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct CounterEntry: TimelineEntry {
    let date: Date
    let count: Int64
}

struct CounterEntryView: View {
    var entry: CounterProvider.Entry

    var body: some View {
        VStack {
            Text("Count:\(entry.count)").font(.largeTitle).fontWeight(.bold)
            Button(intent: CounterAppIntent()) {
                Text("+")
                    .font(.system(size: 40))
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
                    .foregroundColor(.white)
            }
        }
    }
}

struct Counter: Widget {
    let kind: String = "Counter"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: CounterProvider()
        ) { entry in
            CounterEntryView(entry: entry)
        }
    }
}
