import SwiftUI

struct ThemeSelectionView: View {
    @EnvironmentObject var settings: GameSettings
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(Theme.allCases) { theme in
                    Button(action: {
                        settings.theme = theme
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(theme.name)
                                .foregroundColor(.white)
                            Spacer()
                            if settings.theme == theme {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: theme.backgroundColors),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
