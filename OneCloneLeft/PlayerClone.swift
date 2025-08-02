import SpriteKit

class PlayerClone: SKSpriteNode {
    // Properties
    var health: Int = 100
    var weapon: WeaponClone?
    weak var owner: Player?

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, owner: Player?) {
        self.owner = owner
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func attack() {
        weapon?.fire()
    }

    func takeDamage(_ damage: Int) {
        health -= damage
        if health <= 0 {
            die()
        }
    }

    func die() {
        owner?.removeClone(self)
        self.removeFromParent()
    }
}
