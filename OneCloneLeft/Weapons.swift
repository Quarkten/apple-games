import SpriteKit

class Pistol: Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.damage = 10
        self.fireRate = 0.5
        self.reloadTime = 1.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Shotgun: Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.damage = 30
        self.fireRate = 1.0
        self.reloadTime = 1.5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func fire() {
        // Shotguns fire multiple projectiles
    }
}

class Rifle: Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.damage = 20
        self.fireRate = 0.2
        self.reloadTime = 2.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
