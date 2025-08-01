import SpriteKit

class PlayerClone: SKSpriteNode {
    // Properties
    var health: Int = 100
    var weapon: WeaponClone?

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func attack() {
        weapon?.fire()
    }
}
