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

class Zombie: Enemy {
    // Zombies are slow but have high health
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.health = 200
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}
