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
        self.cost = 100
        self.damage = 10
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}

// Tank Defense Structure
class Tank: DefenseStructure {
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .tank)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}
