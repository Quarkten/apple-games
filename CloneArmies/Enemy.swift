import SpriteKit

class Enemy: Troop {
    // Properties
    weak var player: Player?

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, player: Player?) {
        self.player = player
        super.init(texture: texture, color: color, size: size, type: .sniper) // Default to sniper for now
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func update(dt: TimeInterval) {
        guard let player = player else { return }
        let direction = (player.position - self.position).normalized()
        let velocity = direction * 100.0
        self.position += velocity * CGFloat(dt)
    }
}

extension CGPoint {
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    static func += (left: inout CGPoint, right: CGPoint) {
        left = left + right
    }

    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }

    func normalized() -> CGPoint {
        return CGPoint(x: x / length(), y: y / length())
    }
}
