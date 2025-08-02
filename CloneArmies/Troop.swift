import SpriteKit

enum TroopType {
    case sniper
    case jetpack
    case tank
    case tankBoss
    case grenadier
}

// Base Troop Class
class Troop: SKSpriteNode {
    // Properties
    var health: Int
    var isUpgraded: Bool = false
    var type: TroopType
    var attackPower: Int
    private var healthBar: HealthBar!
    var isInCover: Bool = false
    var isSuppressed: Bool = false

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: TroopType) {
        self.type = type
        let upgradeLevel = UpgradeManager.shared.getTroopUpgradeLevel(for: type)
        self.health = 100 + (upgradeLevel * 20)
        self.attackPower = 10 + (upgradeLevel * 5)
        super.init(texture: texture, color: color, size: size)

        healthBar = HealthBar(maxHealth: self.health)
        healthBar.position = CGPoint(x: 0, y: self.size.height / 2 + 10)
        addChild(healthBar)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Methods
    func upgrade() {
        isUpgraded = true
    }

    func takeDamage(_ amount: Int) {
        if isInCover {
            health -= amount / 2 // Take half damage when in cover
        } else {
            health -= amount
        }
        healthBar.update(currentHealth: health)
        if health <= 0 {
            removeFromParent()
        }
    }

    func applySuppression() {
        isSuppressed = true
        let waitAction = SKAction.wait(forDuration: 5.0)
        let removeSuppressionAction = SKAction.run {
            self.isSuppressed = false
        }
        self.run(SKAction.sequence([waitAction, removeSuppressionAction]))
    }

    func takeCover(in scene: SKScene) {
        var closestCover: CoverObject?
        var closestDistance: CGFloat = .greatestFiniteMagnitude

        for node in scene.children {
            if let cover = node as? CoverObject, !cover.isOccupied {
                let distance = self.position.distance(to: cover.position)
                if distance < closestDistance {
                    closestDistance = distance
                    closestCover = cover
                }
            }
        }

        if let cover = closestCover {
            let moveAction = SKAction.move(to: cover.position, duration: 1.0)
            self.run(moveAction) {
                self.isInCover = true
                cover.isOccupied = true
            }
        }
    }
}

// Sniper Troop
class SniperTroop: Troop {
    var attackRange: CGFloat = 200.0

    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .sniper)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Grenadier: Troop {
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .grenadier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// Jetpack Troop
class JetpackTroop: Troop {
    var fuel: CGFloat = 100.0

    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .jetpack)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// Tank Troop
class TankTroop: Troop {
    var armor: Int = 100

    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .tank)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// Weapon Class
class Weapon: SKSpriteNode {
    // Properties
    var damage: Int
    var fireRate: CGFloat
    var type: WeaponType
    var suppressionPower: Int

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: WeaponType) {
        self.type = type
        let upgradeLevel = UpgradeManager.shared.getWeaponUpgradeLevel()
        self.damage = 10 + (upgradeLevel * 5)
        self.fireRate = 1.0 - (CGFloat(upgradeLevel) * 0.1)
        self.suppressionPower = 5 + upgradeLevel
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Methods
    func fire(direction: CGVector) {
        if let gameScene = (self.parent as? Player)?.gameScene {
            let projectile = Projectile(texture: nil, color: .yellow, size: CGSize(width: 10, height: 5), gameScene: gameScene)
            projectile.position = self.position
            projectile.damage = self.damage
            gameScene.addChild(projectile)

            let moveAction = SKAction.move(by: direction * 1000, duration: 2.0)
            let removeAction = SKAction.removeFromParent()
            projectile.run(SKAction.sequence([moveAction, removeAction]))

            // Apply suppression
            for node in gameScene.children {
                if let enemy = node as? Enemy {
                    if projectile.intersects(enemy) {
                        enemy.applySuppression()
                    }
                }
            }
        }
    }
}
