import SpriteKit

class Projectile: SKSpriteNode {
    var damage: Int = 10
    weak var gameScene: GameScene?

    init(texture: SKTexture?, color: UIColor, size: CGSize, gameScene: GameScene?) {
        self.gameScene = gameScene
        super.init(texture: texture, color: color, size: size)
        self.zPosition = Constants.ZPositions.projectile
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
