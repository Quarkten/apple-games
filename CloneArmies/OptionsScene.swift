import SpriteKit

class OptionsScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Options"
        titleLabel.fontSize = 64
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(titleLabel)

        // Create sound toggle button
        let soundButton = SKLabelNode(fontNamed: "Chalkduster")
        soundButton.text = "Sound: ON"
        soundButton.name = "sound_toggle"
        soundButton.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(soundButton)

        // Create back button
        let backButton = SKLabelNode(fontNamed: "Chalkduster")
        backButton.text = "Back"
        backButton.name = "back"
        backButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(backButton)
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
        case "sound_toggle":
            // Toggle sound
            print("Sound toggled")
        case "back":
            let newScene = MainMenuScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        default:
            break
        }
    }
}
