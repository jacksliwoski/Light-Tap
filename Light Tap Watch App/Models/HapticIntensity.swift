import Foundation

enum HapticIntensity: String, CaseIterable, Identifiable {
    case light
    case medium
    case strong

    var id: String { rawValue }
}
