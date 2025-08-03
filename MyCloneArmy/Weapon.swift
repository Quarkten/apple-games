import SpriteKit

class Weapon: SKSpriteNode {
    // Properties
    var level: Int = 1
    var damage: Int = 10

    // Initializer
    init() {
        let texture = SpriteManager.shared.getWeaponTexture()
        super.init(texture: texture, color: .clear, size: texture?.size() ?? .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Methods
    func upgrade() {
        level += 1
        damage += 5
    }

    func fire() {
        // Create and fire a projectile
    }
}
