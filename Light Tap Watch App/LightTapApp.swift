import SwiftUI

@main
struct LightTapApp: App {
    @StateObject private var settings = GameSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
