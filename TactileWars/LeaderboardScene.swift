import SpriteKit

class LeaderboardScene: SKScene {
    override func didMove(to view: SKView) {
        // Create a label to show the leaderboard title
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Leaderboard"
        titleLabel.fontSize = 48
        titleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(titleLabel)

        let leaderboard = OnlineManager.shared.getLeaderboard()

        for (index, entry) in leaderboard.enumerated() {
            let entryLabel = SKLabelNode(fontNamed: "Chalkduster")
            entryLabel.text = "\(index + 1). \(entry.0) - \(entry.1)"
            entryLabel.fontSize = 24
            entryLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 200 - CGFloat(index * 50))
            addChild(entryLabel)
        }
    }
}
