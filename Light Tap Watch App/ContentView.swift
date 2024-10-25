import SwiftUI
import CoreMotion

struct ContentView: View {
    @EnvironmentObject var settings: GameSettings
    @State private var lights: [Light] = []
    @State private var timer: Timer?
    @State private var showSettings = false
    @State private var showLandingPage = true
    @State private var showThemeSelection = false
    @State private var motionManager = CMMotionManager() // For parallax effect
    @State private var xOffset: CGFloat = 0 // For parallax effect
    @State private var yOffset: CGFloat = 0 // For parallax effect

    var body: some View {
        ZStack {
            if showLandingPage {
                LandingPageView(
                    startAction: {
                        showLandingPage = false
                    },
                    changeThemeAction: {
                        showThemeSelection = true
                    },
                    settingsAction: {
                        showSettings = true
                    }
                )
                .environmentObject(settings)
                .sheet(isPresented: $showThemeSelection) {
                    ThemeSelectionView()
                        .environmentObject(settings)
                }
            } else {
                GeometryReader { geometry in
                    ZStack(alignment: .topLeading) {
                        // Ensure the background extends beyond the edges to cover rotation properly
                        AnimatedBackgroundView(shouldAnimateColors: false)
                            .scaleEffect(1.2) // Scale the background slightly larger than the screen
                            .offset(x: xOffset, y: yOffset)
                            .ignoresSafeArea()

                        // Game Lights
                        ForEach(lights) { light in
                            LightView(light: light, removeAction: {
                                removeLight(light)
                            })
                        }

                        // Particle Effects
                        ParticleView()

                        // Done Button
                        Button(action: {
                            stopGame()
                            showLandingPage = true
                            stopMotionUpdates()
                        }) {
                            Text("Done")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .position(x: 30, y: -25)
                    }
                    .onAppear {
                        startGame(screenSize: geometry.size)
                        startMotionUpdates()
                    }
                    .onDisappear {
                        stopGame()
                        stopMotionUpdates()
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .environmentObject(settings)
        }
    }

    // Define the light size as a constant
    private let lightSize: CGFloat = 40

    func startGame(screenSize: CGSize) {
        timer = Timer.scheduledTimer(withTimeInterval: settings.pace.interval, repeats: true) { _ in
            addLight(screenSize: screenSize)
        }
    }

    func stopGame() {
        timer?.invalidate()
        timer = nil
        lights.removeAll()
    }

    func addLight(screenSize: CGSize) {
        if let position = randomPosition(screenSize: screenSize) {
            let newLight = Light(position: position, color: settings.theme.randomColor())
            withAnimation {
                lights.append(newLight)
            }
        }
    }

    func removeLight(_ light: Light) {
        if let index = lights.firstIndex(where: { $0.id == light.id }) {
            withAnimation {
                lights.remove(at: index)
            }
            playFeedback()
        }
    }

    func playFeedback() {
        if settings.hapticEnabled {
            HapticManager.shared.play(type: settings.hapticIntensity)
        }
        if settings.soundEnabled {
            SoundManager.shared.playSound(named: settings.theme.soundOption)
        }
    }

    func randomPosition(screenSize: CGSize) -> CGPoint? {
        let maxAttempts = 10
        let minX = lightSize / 2
        let maxX = screenSize.width - lightSize / 2
        let minY = lightSize / 2
        let maxY = screenSize.height - lightSize / 2

        for _ in 0..<maxAttempts {
            let x = CGFloat.random(in: minX...maxX)
            let y = CGFloat.random(in: minY...maxY)
            let newPosition = CGPoint(x: x, y: y)
            var overlaps = false

            for existingLight in lights {
                let dx = existingLight.position.x - newPosition.x
                let dy = existingLight.position.y - newPosition.y
                let distance = sqrt(dx * dx + dy * dy)
                if distance < lightSize {
                    overlaps = true
                    break
                }
            }

            if !overlaps {
                return newPosition
            }
        }

        // If no suitable position is found after maxAttempts
        return nil
    }

    // Motion updates for parallax effect
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.02
            motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
                guard let data = data else { return }
                let pitch = data.attitude.pitch
                let roll = data.attitude.roll

                withAnimation(.easeOut(duration: 0.1)) {
                    xOffset = CGFloat(roll * 20)
                    yOffset = CGFloat(pitch * 20)
                }
            }
        }
    }

    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}

struct Light: Identifiable {
    let id = UUID()
    let position: CGPoint
    let color: Color
}
