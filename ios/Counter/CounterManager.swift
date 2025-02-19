//
//  CounterManager.swift
//  ReactNativeCounter
//
//  Created by zhongwu on 2025/2/18.
//

class CounterManager {
    static let shared = CounterManager()
    private lazy var mmkv: MMKV? = {
        let appGroup = Bundle.main.object(forInfoDictionaryKey: "AppGroup") as? String ?? ""
        let groupDir = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroup
        )
        if let groupDir = groupDir {
            MMKV
                .initialize(
                    rootDir: nil,
                    groupDir: groupDir.path(),
                    logLevel: .debug
                )
        } else {
            let mmkvBasePath = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first?.appendingPathComponent("mmkv").path
            MMKV.initialize(rootDir: mmkvBasePath, logLevel: .error)
        }
        guard let mmkv = MMKV(mmapID: "mmkv.default", mode: MMKVMode.multiProcess) else {
            return nil
        }
        return mmkv
    }()

    var counter: Int64 {
        get {
            return Int64(mmkv?.double(forKey: "counter") ?? 0)
        }
        set {
            mmkv?.set(Double(newValue), forKey: "counter")
        }
    }

    private init() {}
}
