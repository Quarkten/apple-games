import SpriteKit

enum EnemyState {
    case idle
    case chasing
    case attacking
    case flanking
}

class Enemy: Troop {
    // Properties
    weak var player: Player?
    var state: EnemyState = .idle

    // Initializer
    init(texture: SKTexture?, color: UIColor, size: CGSize, player: Player?, type: TroopType) {
        self.player = player
        super.init(texture: texture, color: color, size: size, type: type)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func update(dt: TimeInterval) {
        guard let player = player else { return }

        switch state {
        case .idle:
            if self.position.distance(to: player.position) < 300 {
                state = .chasing
            }
        case .chasing:
            let direction = (player.position - self.position).normalized()
            let velocity = direction * 100.0
            self.position += velocity * CGFloat(dt)
            if self.position.distance(to: player.position) < 100 {
                state = .attacking
            }
        case .attacking:
            // Attack the player
            if self.health < 30 {
                self.takeCover(in: self.scene!)
            } else if Int.random(in: 0...100) < 10 {
                state = .flanking
            } else if self.position.distance(to: player.position) > 150 {
                state = .chasing
            }
        case .flanking:
            flank(player: player, dt: dt)
        }
    }

    func flank(player: Player, dt: TimeInterval) {
        let flankDirection = CGVector(dx: -player.position.y, dy: player.position.x).normalized()
        let flankPosition = player.position + flankDirection * 100
        let direction = (flankPosition - self.position).normalized()
        let velocity = direction * 100.0
        self.position += velocity * CGFloat(dt)
        if self.position.distance(to: flankPosition) < 10 {
            state = .attacking
        }
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - x, 2) + pow(point.y - y, 2))
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
