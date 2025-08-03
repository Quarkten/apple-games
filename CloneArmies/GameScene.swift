import SpriteKit

/// The main scene for the game.
class GameScene: SKScene {
    // MARK: - Properties

    private var lastUpdateTime: TimeInterval = 0
    private var player: Player?
    private var clones: [Clone] = []
    private var troops: [Troop] = []
    private var enemies: [Enemy] = []
    private var bosses: [Boss] = []
    private var challenge: Challenge?
    private var isAttacking: Bool = false
    private var challengeTimer: TimeInterval = 0
    private var challengeEnemyCount: Int = 0
    private var hud: HUD!
    private var attackModeIndicator: SKShapeNode!
    private var pauseMenu: PauseMenu!

    // MARK: - Scene Lifecycle

    override func didMove(to view: SKView) {
        player = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50), gameScene: self)
        player?.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player!)

        hud = HUD()
        hud.position = CGPoint(x: 0, y: view.frame.height - 100)
        addChild(hud)

        attackModeIndicator = SKShapeNode(rect: self.frame)
        attackModeIndicator.strokeColor = .red
        attackModeIndicator.lineWidth = 10
        attackModeIndicator.isHidden = true
        addChild(attackModeIndicator)

        pauseMenu = PauseMenu()
        pauseMenu.position = CGPoint(x: frame.midX, y: frame.midY)
        pauseMenu.isHidden = true
        addChild(pauseMenu)

        let pauseButton = SKLabelNode(fontNamed: "Chalkduster")
        pauseButton.text = "Pause"
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: frame.maxX - 100, y: frame.maxY - 50)
        addChild(pauseButton)

        let takeCoverButton = SKLabelNode(fontNamed: "Chalkduster")
        takeCoverButton.text = "Take Cover"
        takeCoverButton.name = "take_cover"
        takeCoverButton.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        addChild(takeCoverButton)

        // Add cover objects
        for i in 0..<3 {
            let cover = CoverObject(color: .brown, size: CGSize(width: 50, height: 100))
            cover.position = CGPoint(x: 200 + i * 150, y: 300)
            addChild(cover)
        }

        startMission()
    }

    convenience init(challenge: Challenge) {
        self.init(size: CGSize(width: 1024, height: 768)) // Or your desired size
        self.challenge = challenge
    }

    func startMission() {
        enemies.forEach { $0.removeFromParent() }
        bosses.forEach { $0.removeFromParent() }
        enemies.removeAll()
        bosses.removeAll()

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

        challengeTimer = 0
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

    // MARK: - User Input

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name {
                switch nodeName {
                case "pause":
                    self.isPaused = true
                    pauseMenu.isHidden = false
                case "resume":
                    self.isPaused = false
                    pauseMenu.isHidden = true
                case "quit_to_main_menu":
                    let newScene = MainMenuScene(size: self.size)
                    newScene.scaleMode = .aspectFill
                    view?.presentScene(newScene)
                case "take_cover":
                    for troop in troops {
                        troop.takeCover(in: self)
                    }
                default:
                    isAttacking.toggle()
                    attackModeIndicator.isHidden = !isAttacking
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if isAttacking {
            let direction = (location - player.position).normalized()
            player.attack(direction: direction)
        } else {
            player.move(to: location)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isAttacking = false
        attackModeIndicator.isHidden = true
    }

    // MARK: - Game Logic

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
        let clone = Clone(texture: nil, color: .green, size: CGSize(width: 50, height: 50), gameScene: self)
        clone.position = player.position
        clones.append(clone)
        addChild(clone)

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

        for clone in clones {
            clone.update(dt: dt)
        }

        if let player = player {
            hud.updateHealth(player.health)
        }
        hud.updateResources(GameManager.shared.resources)
        if let mission = MissionManager.shared.getCurrentMission() {
            hud.updateObjective(mission.title)
        }

        for enemy in enemies {
            enemy.update(dt: dt)
        }

        for boss in bosses {
            if Int.random(in: 0...100) < 5 { // 5% chance to use special attack
                boss.specialAttack()
            }
        }

        for projectile in self.children.compactMap({ $0 as? Projectile }) {
            for enemy in enemies {
                if projectile.intersects(enemy) {
                    enemy.takeDamage(projectile.damage)
                    projectile.removeFromParent()
                }
            }
            for boss in bosses {
                if projectile.intersects(boss) {
                    boss.takeDamage(projectile.damage)
                    projectile.removeFromParent()
                }
            }
        }

        var defeatedEnemies: [Enemy] = []
        for enemy in enemies {
            if enemy.health <= 0 {
                defeatedEnemies.append(enemy)
                enemyDefeated(at: enemy.position)
            }
        }
        enemies.removeAll { defeatedEnemies.contains($0) }

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
        } else if let mission = MissionManager.shared.getCurrentMission() {
            switch mission.objective {
            case .defeatAllEnemies:
                if enemies.isEmpty && bosses.isEmpty {
                    missionComplete()
                }
            case .survive(let duration):
                if challengeTimer == 0 {
                    challengeTimer = duration
                }
                challengeTimer -= dt
                if challengeTimer <= 0 {
                    missionComplete()
                }
            case .defeatBoss:
                if bosses.isEmpty {
                    missionComplete()
                }
            }
        }
    }

    func challengeComplete() {
        print("Challenge Complete!")
        // Give reward
        // Go back to main menu or show a victory screen
    }

    func enemyDefeated(at position: CGPoint) {
        SoundManager.shared.playSound(named: "explosion")
        if let explosion = SKEmitterNode(fileNamed: "Explosion") {
            explosion.position = position
            addChild(explosion)
            let waitAction = SKAction.wait(forDuration: 1.0)
            let removeAction = SKAction.removeFromParent()
            explosion.run(SKAction.sequence([waitAction, removeAction]))
        }
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

    func screenShake() {
        let shake = SKAction.shake(duration: 0.5, amplitudeX: 10, amplitudeY: 10)
        self.run(shake)
    }

    func spawnEnemy(type: TroopType) {
        let troop: Troop
        if type == .tankBoss {
            let boss = TankBoss(texture: nil, color: .black, size: CGSize(width: 150, height: 150), player: player)
            bosses.append(boss)
            troop = boss
        } else {
            let enemy = Enemy(texture: nil, color: .purple, size: CGSize(width: 50, height: 50), player: player, type: type)
            enemies.append(enemy)
            troop = enemy
        }
        troop.position = CGPoint(x: frame.maxX - 100, y: frame.midY)
        addChild(troop)
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
        case 24: // 7
            let newScene = UpgradeScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        case 25: // 8
            let newScene = MainMenuScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        default:
            break
        }
    }
}
