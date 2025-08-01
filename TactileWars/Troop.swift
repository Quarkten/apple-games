import SpriteKit

class Troop: SKSpriteNode {
    // Properties
    var health: Int = 100
    var movementSpeed: CGFloat = 100.0

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func move(along path: CGPath) {
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: true, speed: movementSpeed)
        self.run(followPath)
    }
}
