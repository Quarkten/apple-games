import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "One Clone Left"
        titleLabel.fontSize = 64
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(titleLabel)

        // Create buttons
        let singlePlayerButton = SKLabelNode(fontNamed: "Chalkduster")
        singlePlayerButton.text = "Single Player"
        singlePlayerButton.name = "single_player"
        singlePlayerButton.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(singlePlayerButton)

        let multiplayerButton = SKLabelNode(fontNamed: "Chalkduster")
        multiplayerButton.text = "Multiplayer"
        multiplayerButton.name = "multiplayer"
        multiplayerButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(multiplayerButton)
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
        case "single_player":
            let newScene = GameScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        case "multiplayer":
            let newScene = LobbyBrowserScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        default:
            break
        }
    }
}
