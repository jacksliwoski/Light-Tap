import Foundation

enum Pace: String, CaseIterable, Identifiable {
    case slow
    case medium
    case fast

    var id: String { rawValue }

    var interval: TimeInterval {
        switch self {
        case .slow:
            return 2.0
        case .medium:
            return 1.0
        case .fast:
            return 0.5
        }
    }
}
