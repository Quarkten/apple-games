import SpriteKit

class GrenadeLauncher: Weapon {
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size, type: .grenadeLauncher)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func fire(direction: CGVector) {
        if let gameScene = (self.parent as? Player)?.gameScene {
            let grenade = Projectile(texture: nil, color: .green, size: CGSize(width: 20, height: 20), gameScene: gameScene)
            grenade.position = self.position
            grenade.damage = self.damage
            gameScene.addChild(grenade)

            let moveAction = SKAction.move(by: direction * 300, duration: 1.0)
            let removeAction = SKAction.removeFromParent()
            grenade.run(SKAction.sequence([moveAction, removeAction]))
        }
    }
}
