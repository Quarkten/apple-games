import SpriteKit

class Clone: SKSpriteNode {
    // Properties
    var health: Int = 100
    private var actions: [SKAction] = []

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        // Additional setup
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Methods
    func recordAction(_ action: SKAction) {
        actions.append(action)
    }

    func followRecordedActions() {
        self.run(SKAction.sequence(actions))
    }
}
