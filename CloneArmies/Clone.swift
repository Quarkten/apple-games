import SpriteKit

class Clone: Troop {
    // Properties
    weak var gameScene: GameScene?

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, gameScene: GameScene?) {
        self.gameScene = gameScene
        super.init(texture: texture, color: color, size: size, type: .sniper) // Clones are snipers for now
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Methods
    func update(dt: TimeInterval) {
        if let closestEnemy = findClosestEnemy() {
            let direction = (closestEnemy.position - self.position).normalized()
            self.zRotation = atan2(direction.y, direction.x)
            // Fire at the enemy
        }
    }

    private func findClosestEnemy() -> Enemy? {
        var closestEnemy: Enemy?
        var closestDistance: CGFloat = .greatestFiniteMagnitude

        for node in gameScene?.children ?? [] {
            if let enemy = node as? Enemy {
                let distance = self.position.distance(to: enemy.position)
                if distance < closestDistance {
                    closestDistance = distance
                    closestEnemy = enemy
                }
            }
        }
        return closestEnemy
    }
}
