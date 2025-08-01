import SpriteKit

class AnimationManager {
    static let shared = AnimationManager()

    private var troopAnimations: [TroopType: [String: [SKTexture]]] = [:]

    private init() {
        // In a real game, you would load these textures from a texture atlas
        // For now, I'll just create some placeholder animations
        troopAnimations[.infantry] = [
            "walk": [SKTexture(imageNamed: "infantry_walk_1.png"), SKTexture(imageNamed: "infantry_walk_2.png")],
            "attack": [SKTexture(imageNamed: "infantry_attack_1.png"), SKTexture(imageNamed: "infantry_attack_2.png")],
            "death": [SKTexture(imageNamed: "infantry_death_1.png"), SKTexture(imageNamed: "infantry_death_2.png")]
        ]
    }

    func getAnimation(for troopType: TroopType, named: String) -> SKAction? {
        guard let textures = troopAnimations[troopType]?[named] else { return nil }
        return SKAction.animate(with: textures, timePerFrame: 0.1)
    }
}
