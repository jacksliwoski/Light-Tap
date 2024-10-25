import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: GameSettings

    var body: some View {
        Form {
            Section(header: Text("Pace")) {
                Picker("Pace", selection: $settings.pace) {
                    ForEach(Pace.allCases, id: \.self) { pace in
                        Text(pace.rawValue.capitalized).tag(pace)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }

            Section(header: Text("Haptic Feedback")) {
                Toggle("Enable Haptics", isOn: $settings.hapticEnabled)
                if settings.hapticEnabled {
                    Picker("Intensity", selection: $settings.hapticIntensity) {
                        ForEach(HapticIntensity.allCases, id: \.self) { intensity in
                            Text(intensity.rawValue.capitalized).tag(intensity)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }

            //Section(header: Text("Sounds")) {
            //    Toggle("Enable Sounds", isOn: $settings.soundEnabled)
            //}
        }
    }
}
