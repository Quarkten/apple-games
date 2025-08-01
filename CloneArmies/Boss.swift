import SpriteKit

class Boss: Troop {
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .sniper) // Bosses are a special type
        self.health = 1000
        self.attackPower = 50
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func specialAttack() {
        // Implemented by subclasses
    }
}

class TankBoss: Boss {
    override func specialAttack() {
        let rocket = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 10))
        rocket.position = self.position
        self.parent?.addChild(rocket)

        let moveAction = SKAction.moveBy(x: -500, y: 0, duration: 2.0)
        let removeAction = SKAction.removeFromParent()
        rocket.run(SKAction.sequence([moveAction, removeAction]))
    }
}
