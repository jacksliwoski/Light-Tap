import SwiftUI

// Define custom colors
extension Color {
    static let softAmber = Color(red: 1.0, green: 0.75, blue: 0.5)
    static let emeraldGreen = Color(red: 0.0, green: 0.5, blue: 0.0)
    static let paleGreen = Color(red: 0.6, green: 0.8, blue: 0.6)
    static let lavender = Color(red: 0.7, green: 0.6, blue: 0.8)
    static let softYellow = Color(red: 1.0, green: 1.0, blue: 0.8)
    static let silver = Color(red: 0.85, green: 0.85, blue: 0.85) // Brighter silver
    static let pearlWhite = Color(red: 0.95, green: 0.95, blue: 0.95)
    static let seafoamGreen = Color(red: 0.72, green: 0.95, blue: 0.85) // Brighter seafoam green
}

enum Theme: String, CaseIterable, Identifiable {
    case sunsetGlow, oceanLights, forestTwilight

    var id: String { rawValue }

    var name: String {
        switch self {
        case .sunsetGlow:
            return "Sunset Glow"
        case .oceanLights:
            return "Ocean Lights"
        case .forestTwilight:
            return "Forest Twilight"
        }
    }

    // Provide background colors as an array for gradients
    var backgroundColors: [Color] {
        switch self {
        case .sunsetGlow:
            return [Color.orange, Color.red]
        case .oceanLights:
            return [Color.blue, Color.teal]
        case .forestTwilight:
            return [Color.emeraldGreen, Color.softAmber]
        }
    }

    func randomColor() -> Color {
        switch self {
        case .sunsetGlow:
            // Sunset theme light colors
            return [Color.yellow, Color.white].randomElement()!
        case .oceanLights:
            // Ocean Lights theme light colors
            return [
                Color.silver,
                Color.pearlWhite,
                Color.seafoamGreen
            ].randomElement()!
        case .forestTwilight:
            // Updated light colors for Forest Twilight theme
            return [
                Color.softYellow,
                Color.lavender,
                Color.paleGreen
            ].randomElement()!
        }
    }

    var soundOption: String {
        switch self {
        case .sunsetGlow:
            return "wind" // Sound file for gentle wind
        case .oceanLights:
            return "ocean" // Sound file for ocean waves
        case .forestTwilight:
            return "forest" // Sound file for rustling leaves or crickets
        }
    }
}
