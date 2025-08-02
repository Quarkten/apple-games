import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Tactile Wars"
        titleLabel.fontSize = 64
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(titleLabel)

        // Create buttons
        let startButton = SKLabelNode(fontNamed: "Chalkduster")
        startButton.text = "Start Game"
        startButton.name = "start_game"
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(startButton)

        let baseEditorButton = SKLabelNode(fontNamed: "Chalkduster")
        baseEditorButton.text = "Base Editor"
        baseEditorButton.name = "base_editor"
        baseEditorButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(baseEditorButton)
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
            let newScene = GameScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        case "base_editor":
            let newScene = BaseScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        default:
            break
        }
    }
}
