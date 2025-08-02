import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        SoundManager.shared.playMusic(named: "background_music")
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Clone Armies"
        titleLabel.fontSize = 64
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(titleLabel)

        // Create buttons
        let startButton = SKLabelNode(fontNamed: "Chalkduster")
        startButton.text = "Start Game"
        startButton.name = "start_game"
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(startButton)

        let optionsButton = SKLabelNode(fontNamed: "Chalkduster")
        optionsButton.text = "Options"
        optionsButton.name = "options"
        optionsButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(optionsButton)

        let quitButton = SKLabelNode(fontNamed: "Chalkduster")
        quitButton.text = "Quit Game"
        quitButton.name = "quit_game"
        quitButton.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(quitButton)
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
        SoundManager.shared.playSound(named: "button_press")
        switch name {
        case "start_game":
            let newScene = MissionSelectionScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        case "options":
            let newScene = OptionsScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
        case "quit_game":
            // This will only work on a real device or in the simulator
            exit(0)
        default:
            break
        }
    }
}
