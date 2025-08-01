import SpriteKit

class LeaderboardScene: SKScene {
    override func didMove(to view: SKView) {
        // Create a label to show the leaderboard title
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Leaderboard"
        titleLabel.fontSize = 48
        titleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(titleLabel)

        // In a real game, you would fetch the leaderboard data from a server
        // For now, I'll just display some dummy data
        let dummyData = [
            ("Player 1", 1000),
            ("Player 2", 800),
            ("Player 3", 600),
            ("Player 4", 400),
            ("Player 5", 200)
        ]

        for (index, entry) in dummyData.enumerated() {
            let entryLabel = SKLabelNode(fontNamed: "Chalkduster")
            entryLabel.text = "\(index + 1). \(entry.0) - \(entry.1)"
            entryLabel.fontSize = 24
            entryLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 200 - CGFloat(index * 50))
            addChild(entryLabel)
        }
    }
}
