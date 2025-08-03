import SpriteKit

class Pistol: Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.damage = 10
        self.fireRate = 0.5
        self.reloadTime = 1.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class RocketLauncher: Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.damage = 100
        self.fireRate = 2.0
        self.reloadTime = 5.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func fire() {
        // Rockets create an explosion on impact
    }
}

class LaserRifle: Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.damage = 15
        self.fireRate = 0.1
        self.reloadTime = 2.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func fire() {
        // Laser rifle fires a continuous beam
    }
}

class Flamethrower: Weapon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.damage = 5
        self.fireRate = 0.1
        self.reloadTime = 3.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func fire() {
        // Flamethrower creates a continuous stream of fire
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
        super.init(coder: aDecoder)
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
        super.init(coder: aDecoder)
    }
}
