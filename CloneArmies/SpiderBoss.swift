import SpriteKit

class SpiderBoss: Boss {
    init(texture: SKTexture?, color: UIColor, size: CGSize, player: Player?) {
        super.init(texture: texture, color: color, size: size, player: player)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func specialAttack() {
        // The spider boss will spawn smaller spiders
        for _ in 0..<3 {
            let spider = Enemy(texture: nil, color: .black, size: CGSize(width: 30, height: 30), player: self.player, type: .sniper)
            spider.position = self.position
            self.parent?.addChild(spider)
        }
    }
}
