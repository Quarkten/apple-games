import SpriteKit

class Boss: Troop {
    weak var player: Player?

    init(texture: SKTexture?, color: UIColor, size: CGSize, player: Player?) {
        self.player = player
        super.init(texture: texture, color: color, size: size, type: .tankBoss)
        self.health = 1000
        self.attackPower = 50
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func specialAttack() {
        // Implemented by subclasses
    }
}

class TankBoss: Boss {
    init(texture: SKTexture?, color: UIColor, size: CGSize, player: Player?) {
        super.init(texture: texture, color: color, size: size, player: player)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func specialAttack() {
        let rocket = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 10))
        rocket.position = self.position
        self.parent?.addChild(rocket)

        let moveAction = SKAction.moveBy(x: -500, y: 0, duration: 2.0)
        let removeAction = SKAction.removeFromParent()
        rocket.run(SKAction.sequence([moveAction, removeAction]))
    }
}
