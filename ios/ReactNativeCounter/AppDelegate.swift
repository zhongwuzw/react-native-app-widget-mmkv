import React
import React_RCTAppDelegate
import ReactAppDependencyProvider
import UIKit
import WidgetKit

@main
class AppDelegate: RCTAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        moduleName = "ReactNativeCounter"
        dependencyProvider = RCTAppDependencyProvider()

        // You can add your custom initial props in the dictionary below.
        // They will be passed down to the ViewController used by React Native.
        initialProps = [:]

        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    @objc func appDidEnterBackground() {
        // We should reload the Widget to refresh the counter
        WidgetCenter.shared.reloadTimelines(ofKind: "Counter")
    }

    override func sourceURL(for _: RCTBridge) -> URL? {
        bundleURL()
    }

    override func bundleURL() -> URL? {
        #if DEBUG
            RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
        #else
            Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }
}
