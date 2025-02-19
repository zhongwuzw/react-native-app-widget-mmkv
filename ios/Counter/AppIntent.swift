//
//  AppIntent.swift
//  Counter
//
//  Created by zhongwu on 2025/2/18.
//

import AppIntents
import WidgetKit

struct CounterAppIntent: AppIntent {
    static var title: LocalizedStringResource { "Counter Intent" }
    static var description: IntentDescription { "This is an counter intent." }

    func perform() async throws -> some IntentResult {
        CounterManager.shared.counter += 1
        return .result()
    }
}
