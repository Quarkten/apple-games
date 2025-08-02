import SpriteKit

class PlayerClone: SKSpriteNode {
    // Properties
    var health: Int
    var weapon: Weapon?
    private var healthBar: HealthBar!

    // Initializer
    init() {
        let healthLevel = UpgradeSystem.shared.healthUpgradeLevel
        self.health = 100 + (healthLevel * 20)
        let texture = SpriteManager.shared.getCloneTexture()
        super.init(texture: texture, color: .clear, size: texture?.size() ?? .zero)

        healthBar = HealthBar(maxHealth: self.health)
        healthBar.position = CGPoint(x: 0, y: self.size.height / 2 + 10)
        addChild(healthBar)
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
        healthBar.update(currentHealth: health)
        if health <= 0 {
            die()
        }
    }

    func walk() {
        if let animation = AnimationManager.shared.getAnimation(named: "walk") {
            self.run(SKAction.repeatForever(animation))
        }
    }

    func attack() {
        if let animation = AnimationManager.shared.getAnimation(named: "attack") {
            self.run(animation)
        }
    }

    func die() {
        if let deathEffect = SKEmitterNode(fileNamed: "Death") {
            deathEffect.position = self.position
            self.parent?.addChild(deathEffect)
            let waitAction = SKAction.wait(forDuration: 1.0)
            let removeAction = SKAction.removeFromParent()
            deathEffect.run(SKAction.sequence([waitAction, removeAction]))
        }

        if let animation = AnimationManager.shared.getAnimation(named: "death") {
            self.run(animation) {
                self.removeFromParent()
            }
        } else {
            self.removeFromParent()
        }
    }
}
