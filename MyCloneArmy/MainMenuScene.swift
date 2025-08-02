import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "My Clone Army"
        titleLabel.fontSize = 64
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(titleLabel)

        // Create buttons
        let startButton = SKLabelNode(fontNamed: "Chalkduster")
        startButton.text = "Start Game"
        startButton.name = "start_game"
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(startButton)

        let armyButton = SKLabelNode(fontNamed: "Chalkduster")
        armyButton.text = "My Army"
        armyButton.name = "my_army"
        armyButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(armyButton)

        let friendsButton = SKLabelNode(fontNamed: "Chalkduster")
        friendsButton.text = "Friends"
        friendsButton.name = "friends"
        friendsButton.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(friendsButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name {
                handleButtonPress(name: nodeName)
            }
        }
    }

    func handleButtonPress(name: String) {
        switch name {
        case "start_game":
            // In a real game, you would transition to a lobby browser scene
            let newScene = GameScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        case "my_army":
            let newScene = ArmyManagementScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        case "friends":
            let newScene = FriendsScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        default:
            break
        }
    }
}
