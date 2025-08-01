import SpriteKit

class Projectile: SKSpriteNode {
    var damage: Int = 10

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = Constants.ZPositions.projectile
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
