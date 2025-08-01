import SpriteKit

class Player: SKSpriteNode {
    // Properties
    var health: Int = 100
    var equippedWeapon: Weapon?
    private var actions: [SKAction] = []
    weak var gameScene: GameScene?

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, gameScene: GameScene?) {
        self.gameScene = gameScene
        super.init(texture: texture, color: color, size: size)
        // Additional setup
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func recordAction(_ action: SKAction) {
        actions.append(action)
    }

    func move(to position: CGPoint) {
        let moveAction = SKAction.move(to: position, duration: 0.1)
        self.run(moveAction)
        recordAction(moveAction)
    }

    func attack() {
        let attackAction = SKAction.run { [weak self] in
            self?.equippedWeapon?.fire()
        }
        self.run(attackAction)
        recordAction(attackAction)
    }

    func takeDamage(_ amount: Int) {
        health -= amount
        if health <= 0 {
            die()
        }
    }

    private func die() {
        gameScene?.playerDidDie()
    }

    func getRecordedActions() -> [SKAction] {
        return actions
    }
}
