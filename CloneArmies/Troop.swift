import SpriteKit

enum TroopType {
    case sniper
    case jetpack
    case tank
    case tankBoss
}

// Base Troop Class
class Troop: SKSpriteNode {
    // Properties
    var health: Int
    var isUpgraded: Bool = false
    var type: TroopType
    var attackPower: Int

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: TroopType) {
        self.type = type
        let upgradeLevel = UpgradeManager.shared.getTroopUpgradeLevel(for: type)
        self.health = 100 + (upgradeLevel * 20)
        self.attackPower = 10 + (upgradeLevel * 5)
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func upgrade() {
        isUpgraded = true
    }

    func takeDamage(_ amount: Int) {
        health -= amount
        if health <= 0 {
            removeFromParent()
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
        fatalError("init(coder:) has not been implemented")
    }
}

// Jetpack Troop
class JetpackTroop: Troop {
    var fuel: CGFloat = 100.0

    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .jetpack)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Tank Troop
class TankTroop: Troop {
    var armor: Int = 100

    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .tank)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Weapon Class
class Weapon: SKSpriteNode {
    // Properties
    var damage: Int
    var fireRate: CGFloat

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let upgradeLevel = UpgradeManager.shared.getWeaponUpgradeLevel()
        self.damage = 10 + (upgradeLevel * 5)
        self.fireRate = 1.0 - (CGFloat(upgradeLevel) * 0.1)
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func fire() {
        print("Firing weapon!")
    }
}
