import SwiftUI

struct LandingPageView: View {
    @EnvironmentObject var settings: GameSettings

    var startAction: () -> Void
    var changeThemeAction: () -> Void
    var settingsAction: () -> Void

    var body: some View {
        ZStack {
            // Animated Background
            AnimatedBackgroundView(shouldAnimateColors: true)
                .ignoresSafeArea()

            VStack {
                // Centered Settings Button
                Button(action: settingsAction) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 8)

                Spacer()

                VStack(spacing: 20) {
                    Button(action: startAction) {
                        Text("Start")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: changeThemeAction) {
                        Text("Change Theme")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                Spacer()
            }
        }
    }
}
