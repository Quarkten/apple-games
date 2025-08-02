import SpriteKit

class GameScene: SKScene {
    // Properties
    private var player: Player!
    private var enemies: [SKSpriteNode] = []

    // Scene Lifecycle
    override func didMove(to view: SKView) {
        let levelGenerator = LevelGenerator(width: 50, height: 30)
        levelGenerator.generateLevel()
        renderLevel(tiles: levelGenerator.getTiles())

        player = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player)

        let cloneButton = SKLabelNode(fontNamed: "Chalkduster")
        cloneButton.text = "Clone"
        cloneButton.name = "clone"
        cloneButton.position = CGPoint(x: frame.minX + 100, y: frame.minY + 100)
        addChild(cloneButton)

        startMission()
    }

    func renderLevel(tiles: [[TileType]]) {
        let tileSize = CGSize(width: 32, height: 32)
        for (x, row) in tiles.enumerated() {
            for (y, tileType) in row.enumerated() {
                let tileNode = SKSpriteNode()
                tileNode.size = tileSize
                tileNode.position = CGPoint(x: x * Int(tileSize.width), y: y * Int(tileSize.height))
                switch tileType {
                case .wall:
                    tileNode.color = .gray
                case .floor:
                    tileNode.color = .lightGray
                case .door:
                    tileNode.color = .brown
                }
                addChild(tileNode)
            }
        }
    }

    func startMission() {
        guard let mission = MissionManager.shared.getCurrentMission() else { return }

        switch mission.objective {
        case .defeatAllEnemies:
            // Spawn all enemies at once
            for wave in mission.enemyWaves {
                for enemyType in wave {
                    let enemy = enemyType.init(texture: nil, color: .red, size: CGSize(width: 40, height: 40))
                    // Position the enemy
                    // addChild(enemy)
                    // self.enemies.append(enemy)
                }
            }
        case .survive(let duration):
            // Spawn enemies in waves
            var waveActions: [SKAction] = []
            for wave in mission.enemyWaves {
                let spawnWaveAction = SKAction.run {
                    for enemyType in wave {
                        let enemy = enemyType.init(texture: nil, color: .red, size: CGSize(width: 40, height: 40))
                        // Position the enemy
                        // addChild(enemy)
                        // self.enemies.append(enemy)
                    }
                }
                waveActions.append(spawnWaveAction)
                waveActions.append(SKAction.wait(forDuration: 10.0)) // Delay between waves
            }
            self.run(SKAction.sequence(waveActions))
        case .escort(let npc):
            // Add the NPC to the scene
            // ...
            break
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if node.name == "clone" {
                player.clone()
            }
        }
    }

    // Game Loop
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
