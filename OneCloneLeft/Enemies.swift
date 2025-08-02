import SpriteKit

class Enemy: SKSpriteNode {
    var health: Int = 100

    func update(player: Player) {
        // Basic AI: move towards the player
        let direction = (player.position - self.position).normalized()
        let velocity = direction * 50.0
        self.position += velocity * 0.016 // Assuming 60 FPS
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }

    func normalized() -> CGPoint {
        let length = distance(to: .zero)
        return CGPoint(x: x / length, y: y / length)
    }

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    static func += (left: inout CGPoint, right: CGPoint) {
        left = CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
}

class Zombie: Enemy {
    // Zombies are slow but have high health
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.health = 200
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Mutant: Enemy {
    // Mutants are fast and shoot projectiles
    override func update(player: Player) {
        super.update(player: player)

        if Int.random(in: 0...100) < 2 { // 2% chance to shoot
            let projectile = SKSpriteNode(color: .red, size: CGSize(width: 10, height: 10))
            projectile.position = self.position
            self.parent?.addChild(projectile)

            let direction = (player.position - self.position).normalized()
            let moveAction = SKAction.move(by: direction * 500, duration: 2.0)
            let removeAction = SKAction.removeFromParent()
            projectile.run(SKAction.sequence([moveAction, removeAction]))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Giant: Enemy {
    // Giants are slow, have high health, and do a lot of damage
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.health = 500
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Spitter: Enemy {
    // Spitters stay at a distance and spit acid
    override func update(player: Player) {
        let distance = self.position.distance(to: player.position)
        if distance < 200 {
            if Int.random(in: 0...100) < 3 {
                let acid = SKShapeNode(circleOfRadius: 15)
                acid.fillColor = .green
                acid.position = self.position
                self.parent?.addChild(acid)

                let moveAction = SKAction.move(to: player.position, duration: 1.0)
                let removeAction = SKAction.removeFromParent()
                acid.run(SKAction.sequence([moveAction, removeAction]))
            }
        } else {
            super.update(player: player)
        }
    }
}

class Charger: Enemy {
    // Chargers charge at the player
    private var isCharging = false

    override func update(player: Player) {
        if isCharging { return }

        let distance = self.position.distance(to: player.position)
        if distance < 150 {
            isCharging = true
            let direction = (player.position - self.position).normalized()
            let chargeAction = SKAction.move(by: direction * 300, duration: 0.5)
            let waitAction = SKAction.wait(forDuration: 1.0)
            let sequence = SKAction.sequence([chargeAction, waitAction]) {
                self.isCharging = false
            }
            self.run(sequence)
        } else {
            super.update(player: player)
        }
    }
}
