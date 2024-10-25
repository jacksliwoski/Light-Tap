import SwiftUI

struct LightView: View {
    @State private var isAppearing = false
    @State private var floatAmount: CGFloat = 0
    @State private var animateFloat = false
    let light: Light
    let removeAction: () -> Void

    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [
                        light.color.opacity(0.9),
                        light.color.opacity(0.1)
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 20
                )
            )
            .frame(width: isAppearing ? 40 : 0, height: isAppearing ? 40 : 0)
            .scaleEffect(isAppearing ? 1.0 : 0.5)
            .opacity(isAppearing ? 1.0 : 0.0)
            .shadow(color: light.color.opacity(0.8), radius: 15)
            .position(light.position)
            .onTapGesture {
                removeAction()
                // Add particle effect on tap
                ParticleManager.shared.emitParticles(at: light.position, color: light.color)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) {
                    isAppearing = true
                }
                // Start floating animation
                animateFloat = true
                floatAmount = CGFloat.random(in: -5...5)
            }
            .onDisappear {
                withAnimation(.easeIn(duration: 0.5)) {
                    isAppearing = false
                }
                animateFloat = false
            }
            .offset(y: animateFloat ? floatAmount : 0)
            .animation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true),
                value: animateFloat
            )
    }
}
