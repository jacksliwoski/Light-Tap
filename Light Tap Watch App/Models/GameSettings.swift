import SwiftUI

class GameSettings: ObservableObject {
    @Published var soundEnabled: Bool = true
    @Published var hapticEnabled: Bool = true
    @Published var hapticIntensity: HapticIntensity = .medium
    @Published var pace: Pace = .medium
    @Published var theme: Theme = .sunsetGlow
}
