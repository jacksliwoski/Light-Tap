import WatchKit

class HapticManager {
    static let shared = HapticManager()

    func play(type: HapticIntensity) {
        switch type {
        case .light:
            WKInterfaceDevice.current().play(.click)
        case .medium:
            WKInterfaceDevice.current().play(.directionUp)
        case .strong:
            WKInterfaceDevice.current().play(.success)
        }
    }
}
