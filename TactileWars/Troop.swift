import SpriteKit

class Troop: SKSpriteNode {
    // Properties
    var health: Int = 100
    var movementSpeed: CGFloat = 100.0
    var formationOffset: CGPoint = .zero

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func move(along path: CGPath) {
        let followPath = SKAction.follow(path, asOffset: false, orientToPath: true, speed: movementSpeed)
        let endPoint = path.boundingBox.origin + path.boundingBox.size
        let formationPoint = endPoint + formationOffset
        let moveToAction = SKAction.move(to: formationPoint, duration: 0.5)
        self.run(SKAction.sequence([followPath, moveToAction]))
    }

    func takeDamage(_ damage: Int) {
        health -= damage
        if health <= 0 {
            self.removeFromParent()
        }
    }
}

extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
}

extension CGSize {
    static func + (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width + right.width, height: left.height + right.height)
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - x, 2) + pow(point.y - y, 2))
    }

    func normalized() -> CGPoint {
        let length = self.distance(to: .zero)
        return CGPoint(x: self.x / length, y: self.y / length)
    }
}
