import SpriteKit

class GameScene: SKScene {
    // Properties
    private var lastUpdateTime: TimeInterval = 0
    private var player: Player?
    private var clones: [Clone] = []
    private var troops: [Troop] = []
    private var enemies: [Enemy] = []

    // Scene Lifecycle
    override func didMove(to view: SKView) {
        player = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50), gameScene: self)
        player?.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player!)
    }

    // User Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        player?.move(to: location)
    }

    // Game Logic
    func spawnTroop(type: TroopType) {
        let troop: Troop
        switch type {
        case .sniper:
            troop = SniperTroop(texture: nil, color: .red, size: CGSize(width: 50, height: 50))
        case .jetpack:
            troop = JetpackTroop(texture: nil, color: .orange, size: CGSize(width: 50, height: 50))
        case .tank:
            troop = TankTroop(texture: nil, color: .gray, size: CGSize(width: 80, height: 80))
        }
        troop.position = CGPoint(x: frame.minX + 100, y: frame.midY)
        troops.append(troop)
        addChild(troop)
    }

    func playerDidDie() {
        guard let player = player else { return }
        let clone = Clone(texture: nil, color: .green, size: CGSize(width: 50, height: 50))
        clone.position = player.position
        clone.recordAction(SKAction.sequence(player.getRecordedActions()))
        clones.append(clone)
        addChild(clone)
        clone.followRecordedActions()

        // Respawn player
        self.player?.removeFromParent()
        self.player = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50), gameScene: self)
        self.player?.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(self.player!)
    }

    // Game Loop
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }

        let dt = currentTime - lastUpdateTime
        lastUpdateTime = currentTime

        for enemy in enemies {
            enemy.update(dt: dt)
        }
    }

    func spawnEnemy() {
        let enemy = Enemy(texture: nil, color: .purple, size: CGSize(width: 50, height: 50), player: player)
        enemy.position = CGPoint(x: frame.maxX - 100, y: frame.midY)
        enemies.append(enemy)
        addChild(enemy)
    }

    // Temp for testing
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 49: // Space bar
            player?.takeDamage(100)
        case 18: // 1
            spawnTroop(type: .sniper)
        case 19: // 2
            spawnTroop(type: .jetpack)
        case 20: // 3
            spawnTroop(type: .tank)
        case 21: // 4
            spawnEnemy()
        default:
            break
        }
    }
}
