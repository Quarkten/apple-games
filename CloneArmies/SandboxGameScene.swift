import SpriteKit

class SandboxGameScene: GameScene {
    private var spawnTimer: TimeInterval = 0
    private var spawnInterval: TimeInterval = 5.0
    private var score: Int = 0
    private var scoreLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 24
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        addChild(scoreLabel)
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

        spawnTimer += self.lastUpdateTime
        if spawnTimer >= spawnInterval {
            spawnTimer = 0
            spawnEnemy(type: .sniper) // For now, only spawn snipers

            // Increase difficulty
            if spawnInterval > 1.0 {
                spawnInterval -= 0.1
            }
        }

        score += Int(self.lastUpdateTime * 10) // Score for survival time
        scoreLabel.text = "Score: \(score)"
    }

    override func enemyDefeated() {
        super.enemyDefeated()
        score += 100 // Score for defeating an enemy
    }
}
