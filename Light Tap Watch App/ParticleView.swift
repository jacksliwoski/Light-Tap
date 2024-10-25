import SwiftUI

struct ParticleView: View {
    @ObservedObject var particleManager = ParticleManager.shared

    var body: some View {
        ForEach(particleManager.particles) { particle in
            Circle()
                .fill(particle.color)
                .frame(width: particle.size, height: particle.size)
                .position(particle.position)
                .onAppear {
                    withAnimation(Animation.linear(duration: particle.lifetime)) {
                        particleManager.particles = particleManager.particles.map {
                            if $0.id == particle.id {
                                var updatedParticle = $0
                                updatedParticle.position = CGPoint(
                                    x: $0.position.x + $0.velocity.dx * CGFloat($0.lifetime),
                                    y: $0.position.y + $0.velocity.dy * CGFloat($0.lifetime)
                                )
                                return updatedParticle
                            } else {
                                return $0
                            }
                        }
                    }
                }
        }
    }
}
