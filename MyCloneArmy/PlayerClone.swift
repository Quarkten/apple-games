import SpriteKit

class PlayerClone: SKSpriteNode {
    // Properties
    var health: Int
    var weapon: Weapon?

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let healthLevel = UpgradeSystem.shared.healthUpgradeLevel
        self.health = 100 + (healthLevel * 20)
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func attack(_ target: PlayerClone) {
        // In a real game, the weapon would handle the attack logic
        target.takeDamage(10)
    }

    func takeDamage(_ damage: Int) {
        health -= damage
        if health <= 0 {
            self.removeFromParent()
        }
    }
}
