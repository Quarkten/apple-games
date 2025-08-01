import SpriteKit

class Weapon: SKSpriteNode {
    // Properties
    var level: Int = 1
    var damage: Int = 10

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
