import SpriteKit

class WeaponClone: SKSpriteNode {
    // Properties
    var ammo: Int = 100

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func fire() {
        if ammo > 0 {
            ammo -= 1
            // Create and fire a projectile
        }
    }
}
