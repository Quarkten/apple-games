import SpriteKit

class AnimationManager {
    static let shared = AnimationManager()

    private var cloneAnimations: [String: [SKTexture]] = [:]

    private init() {
        // In a real game, you would load these textures from a texture atlas
        // For now, I'll just create some placeholder animations
        cloneAnimations["walk"] = [SKTexture(imageNamed: "clone_walk_1.png"), SKTexture(imageNamed: "clone_walk_2.png")]
        cloneAnimations["attack"] = [SKTexture(imageNamed: "clone_attack_1.png"), SKTexture(imageNamed: "clone_attack_2.png")]
        cloneAnimations["death"] = [SKTexture(imageNamed: "clone_death_1.png"), SKTexture(imageNamed: "clone_death_2.png")]
    }

    func getAnimation(named: String) -> SKAction? {
        guard let textures = cloneAnimations[named] else { return nil }
        return SKAction.animate(with: textures, timePerFrame: 0.1)
    }
}
