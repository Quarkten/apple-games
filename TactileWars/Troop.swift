import SpriteKit

enum TroopType {
    case infantry
    case ranged
    case cavalry
}

class Troop: SKSpriteNode {
    // Properties
    var health: Int = 100
    var movementSpeed: CGFloat = 100.0
    var formationOffset: CGPoint = .zero
    var type: TroopType
    var attackPower: Int
    var attackRange: CGFloat
    var specialAbility: SpecialAbility?

    // Initializer
    init(type: TroopType) {
        self.type = type
        let texture = SpriteManager.shared.getTexture(for: type)
        switch type {
        case .infantry:
            self.attackPower = 10
            self.attackRange = 50
            self.specialAbility = .shield
        case .ranged:
            self.attackPower = 5
            self.attackRange = 200
            self.specialAbility = .volley
        case .cavalry:
            self.attackPower = 15
            self.attackRange = 75
            self.specialAbility = .charge
        }
        super.init(texture: texture, color: .clear, size: texture?.size() ?? .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Methods
    func move(along path: CGPath) {
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: true, speed: movementSpeed)
        let endPoint = path.boundingBox.origin + path.boundingBox.size
        let formationPoint = endPoint + formationOffset
        let moveToAction = SKAction.move(to: formationPoint, duration: 0.5)
        let stopAnimation = SKAction.run {
            self.removeAllActions()
        }
        self.run(SKAction.sequence([followPath, moveToAction, stopAnimation]))
    }

    func takeDamage(_ damage: Int) {
        health -= damage
        if health <= 0 {
            die()
        }
    }

    func walk() {
        if let animation = AnimationManager.shared.getAnimation(for: type, named: "walk") {
            self.run(SKAction.repeatForever(animation))
        }
    }

    func attack() {
        if let animation = AnimationManager.shared.getAnimation(for: type, named: "attack") {
            self.run(animation)
        }
    }

    func useSpecialAbility() {
        guard let ability = specialAbility else { return }
        switch ability {
        case .charge:
            self.movementSpeed *= 2
            let waitAction = SKAction.wait(forDuration: 5.0)
            let slowDownAction = SKAction.run {
                self.movementSpeed /= 2
            }
            self.run(SKAction.sequence([waitAction, slowDownAction]))
        case .volley:
            // Fire multiple projectiles
            break
        case .shield:
            let shield = SKShapeNode(circleOfRadius: 40)
            shield.fillColor = .blue
            shield.alpha = 0.5
            addChild(shield)
            let waitAction = SKAction.wait(forDuration: 5.0)
            let removeAction = SKAction.removeFromParent()
            shield.run(SKAction.sequence([waitAction, removeAction]))
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

        if let animation = AnimationManager.shared.getAnimation(for: type, named: "death") {
            self.run(animation) {
                self.removeFromParent()
            }
        } else {
            self.removeFromParent()
        }
    }
}

extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
}

extension CGSize {
    static func + (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width + right.width, height: left.height + right.height)
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - x, 2) + pow(point.y - y, 2))
    }

    func normalized() -> CGPoint {
        let length = self.distance(to: .zero)
        return CGPoint(x: self.x / length, y: self.y / length)
    }
}
