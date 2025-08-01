import SpriteKit

enum TroopType {
    case sniper
    case jetpack
    case tank
}

// Base Troop Class
class Troop: SKSpriteNode {
    // Properties
    var health: Int = 100
    var isUpgraded: Bool = false
    var type: TroopType

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, type: TroopType) {
        self.type = type
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func upgrade() {
        isUpgraded = true
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
    var damage: Int = 10

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
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
