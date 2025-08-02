import SpriteKit

class WeeklyChallengesScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Weekly Challenges"
        titleLabel.fontSize = 48
        titleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(titleLabel)

        // In a real game, you would get the list of challenges from the ChallengeManager
        let challenges = [
            ("Survival", "Survive for 2 minutes"),
            ("Elimination", "Defeat 10 enemies")
        ]

        for (index, challenge) in challenges.enumerated() {
            let challengeButton = SKLabelNode(fontNamed: "Chalkduster")
            challengeButton.text = "\(challenge.0): \(challenge.1)"
            challengeButton.name = "challenge_\(index)"
            challengeButton.position = CGPoint(x: frame.midX, y: frame.maxY - 200 - CGFloat(index * 100))
            addChild(challengeButton)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "challenge_") {
                // let challengeIndex = Int(nodeName.replacingOccurrences(of: "challenge_", with: ""))!
                // In a real game, you would start the selected challenge
                if let challenge = ChallengeManager.shared.getWeeklyChallenge() {
                    let newScene = GameScene(challenge: challenge)
                    newScene.scaleMode = .aspectFill
                    view?.presentScene(newScene)
                }
            }
        }
    }
}
