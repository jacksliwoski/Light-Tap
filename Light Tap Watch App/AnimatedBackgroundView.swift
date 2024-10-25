import SwiftUI

struct AnimatedBackgroundView: View {
    @EnvironmentObject var settings: GameSettings
    @State private var animateGradient = false
    var shouldAnimateColors: Bool // New parameter to control hue rotation

    var body: some View {
        GeometryReader { geometry in
            LinearGradient(
                gradient: Gradient(colors: gradientColors()),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .hueRotation(.degrees(shouldAnimateColors ? animateGradient ? 360 : 0 : 0))
            .animation(
                shouldAnimateColors ?
                    Animation.linear(duration: 10).repeatForever(autoreverses: false) : .default,
                value: animateGradient
            )
            .onAppear {
                if shouldAnimateColors {
                    animateGradient = true
                }
            }
            .ignoresSafeArea()
        }
    }

    func gradientColors() -> [Color] {
        return settings.theme.backgroundColors
    }
}
