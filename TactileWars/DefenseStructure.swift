import SpriteKit

enum DefenseType {
    case mine
    case tank
    case cannon
}

// Base Defense Structure Class
class DefenseStructure: SKSpriteNode {
    // Properties
    var health: Int
    var type: DefenseType
    var cost: Int
    var damage: Int
    private var healthBar: HealthBar!

    // Initializer
    init(type: DefenseType) {
        self.type = type
        let texture = SpriteManager.shared.getTexture(for: type)
        if let data = defenseData[type] {
            self.cost = data.cost
            self.health = data.health
            self.damage = data.damage
        } else {
            self.cost = 0
            self.damage = 0
            self.health = 0
        }
        super.init(texture: texture, color: .clear, size: texture?.size() ?? .zero)

        healthBar = HealthBar(maxHealth: self.health)
        healthBar.position = CGPoint(x: 0, y: self.size.height / 2 + 10)
        addChild(healthBar)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func attack(target: Troop) {
        // Implemented by subclasses
    }

    func takeDamage(_ damage: Int) {
        health -= damage
        healthBar.update(currentHealth: health)
        if health <= 0 {
            self.removeFromParent()
        }
    }
}

// Mine Defense Structure
class Mine: DefenseStructure {
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .mine)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func attack(target: Troop) {
        // Explode when the target gets close
        if self.position.distance(to: target.position) < 50 {
            target.health -= self.damage
            self.removeFromParent()
        }
    }
}

// Tank Defense Structure
class Tank: DefenseStructure {
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .tank)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func attack(target: Troop) {
        // Fire a projectile at the target
        let projectile = SKSpriteNode(color: .red, size: CGSize(width: 10, height: 10))
        projectile.position = self.position
        self.parent?.addChild(projectile)

        let direction = (target.position - self.position).normalized()
        let moveAction = SKAction.move(by: direction * 500, duration: 1.0)
        let removeAction = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([moveAction, removeAction]))
    }
}

// Cannon Defense Structure
class Cannon: DefenseStructure {
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .cannon)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func attack(target: Troop) {
        if let animation = AnimationManager.shared.getAnimation(for: .cannon, named: "attack") {
            self.run(animation)
        }
        // Fire a projectile with an area of effect
        let projectile = SKShapeNode(circleOfRadius: 20)
        projectile.position = target.position
        projectile.fillColor = .orange
        self.parent?.addChild(projectile)

        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let removeAction = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([fadeOutAction, removeAction]))
    }
}
