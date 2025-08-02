import SpriteKit

class PauseMenu: SKNode {
    override init() {
        super.init()

        let background = SKShapeNode(rectOf: CGSize(width: 400, height: 300))
        background.fillColor = .black
        background.alpha = 0.8
        addChild(background)

        let resumeButton = SKLabelNode(fontNamed: "Chalkduster")
        resumeButton.text = "Resume"
        resumeButton.name = "resume"
        resumeButton.position = CGPoint(x: 0, y: 50)
        addChild(resumeButton)

        let quitButton = SKLabelNode(fontNamed: "Chalkduster")
        quitButton.text = "Quit to Main Menu"
        quitButton.name = "quit_to_main_menu"
        quitButton.position = CGPoint(x: 0, y: -50)
        addChild(quitButton)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
