import SwiftUI

class ParticleManager: ObservableObject {
    static let shared = ParticleManager()
    @Published var particles: [Particle] = []

    func emitParticles(at position: CGPoint, color: Color) {
        let newParticles = (0..<20).map { _ in
            Particle(
                id: UUID(),
                position: position,
                color: color,
                lifetime: Double.random(in: 0.5...1.0),
                size: CGFloat.random(in: 2...5),
                velocity: CGVector(dx: CGFloat.random(in: -20...20), dy: CGFloat.random(in: -20...20))
            )
        }
        DispatchQueue.main.async {
            self.particles.append(contentsOf: newParticles)
        }

        // Remove particles after their lifetime
        for particle in newParticles {
            DispatchQueue.main.asyncAfter(deadline: .now() + particle.lifetime) {
                self.particles.removeAll { $0.id == particle.id }
            }
        }
    }
}

struct Particle: Identifiable {
    let id: UUID
    var position: CGPoint
    let color: Color
    let lifetime: Double
    let size: CGFloat
    let velocity: CGVector
}
