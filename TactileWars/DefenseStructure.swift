import SpriteKit

enum DefenseType {
    case mine
    case tank
    case cannon
}

// Base Defense Structure Class
class DefenseStructure: SKSpriteNode {
    // Properties
    var health: Int = 200
    var type: DefenseType
    var cost: Int
    var damage: Int

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: DefenseType) {
        self.type = type
        if let data = defenseData[type] {
            self.cost = data.cost
            self.health = data.health
            self.damage = data.damage
        } else {
            self.cost = 0
            self.damage = 0
        }
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func attack(target: Troop) {
        // Implemented by subclasses
    }
}

// Mine Defense Structure
class Mine: DefenseStructure {
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .mine)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        fatalError("init(coder:) has not been implemented")
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
        fatalError("init(coder:) has not been implemented")
    }

    override func attack(target: Troop) {
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
