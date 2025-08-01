import SpriteKit

class GameScene: SKScene {
    // Properties
    private var lastUpdateTime: TimeInterval = 0
    private var player: Player?
    private var clones: [Clone] = []
    private var troops: [Troop] = []
    private var enemies: [Enemy] = []
    private var challenge: Challenge?
    private var challengeTimer: TimeInterval = 0
    private var challengeEnemyCount: Int = 0

    // Scene Lifecycle
    override func didMove(to view: SKView) {
        player = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50), gameScene: self)
        player?.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player!)

        startMission()
    }

    convenience init(challenge: Challenge) {
        self.init(size: CGSize(width: 1024, height: 768)) // Or your desired size
        self.challenge = challenge
    }

    func startMission() {
        guard let mission = MissionManager.shared.getCurrentMission() else {
            // No more missions
            return
        }

        for enemyType in mission.enemyTypes {
            spawnEnemy(type: enemyType)
        }
    }

    func startChallenge() {
        guard let challenge = challenge else { return }

        switch challenge.objective {
        case .survive(let duration):
            challengeTimer = duration
            // Spawn enemies continuously
            let spawnAction = SKAction.repeatForever(SKAction.sequence([
                SKAction.run { self.spawnEnemy(type: .sniper) },
                SKAction.wait(forDuration: 5.0)
            ]))
            run(spawnAction)
        case .defeatEnemies(let count):
            challengeEnemyCount = count
            // Spawn initial enemies
            for _ in 0..<5 {
                spawnEnemy(type: .sniper)
            }
        }
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

        enemies.removeAll { $0.health <= 0 }

        if let challenge = challenge {
            switch challenge.objective {
            case .survive(let duration):
                challengeTimer -= dt
                if challengeTimer <= 0 {
                    challengeComplete()
                }
            case .defeatEnemies(var count):
                let defeatedEnemies = challengeEnemyCount - enemies.count
                if defeatedEnemies >= count {
                    challengeComplete()
                }
            }
        } else {
            if enemies.isEmpty {
                missionComplete()
            }
        }
    }

    func challengeComplete() {
        print("Challenge Complete!")
        // Give reward
        // Go back to main menu or show a victory screen
    }

    func missionComplete() {
        guard let mission = MissionManager.shared.getCurrentMission() else { return }
        print("Mission Complete!")
        GameManager.shared.addResources(mission.reward)
        print("You earned \(mission.reward) resources!")
        MissionManager.shared.advanceToNextMission()
        // You might want to clear the scene and show a mission complete screen
        // before starting the next mission.
        startMission()
    }

    func spawnEnemy(type: TroopType) {
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
        case 22: // 5
            if let firstEnemy = enemies.first {
                firstEnemy.takeDamage(50)
            }
        case 23: // 6
            if let challenge = ChallengeManager.shared.getWeeklyChallenge() {
                let newScene = GameScene(challenge: challenge)
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene)
            }
        default:
            break
        }
    }
}
