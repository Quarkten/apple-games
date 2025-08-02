import SpriteKit

class FriendsScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Friends"
        titleLabel.fontSize = 64
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        addChild(titleLabel)

        // In a real game, you would get the list of friends from a server
        let friends = [
            "Player 2",
            "Player 3",
            "Player 4"
        ]

        for (index, friend) in friends.enumerated() {
            let friendLabel = SKLabelNode(fontNamed: "Chalkduster")
            friendLabel.text = friend
            friendLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100 - CGFloat(index * 50))
            addChild(friendLabel)
        }

        let backButton = SKLabelNode(fontNamed: "Chalkduster")
        backButton.text = "Back"
        backButton.name = "back"
        backButton.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        addChild(backButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if node.name == "back" {
                let newScene = MainMenuScene(size: self.size)
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene)
            }
        }
    }
}
