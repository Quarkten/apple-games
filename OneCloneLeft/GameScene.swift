import SpriteKit

class GameScene: SKScene {
    // Properties
    private var player: Player!
    private var enemies: [SKSpriteNode] = []

    // Scene Lifecycle
    override func didMove(to view: SKView) {
        player = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player)

        let cloneButton = SKLabelNode(fontNamed: "Chalkduster")
        cloneButton.text = "Clone"
        cloneButton.name = "clone"
        cloneButton.position = CGPoint(x: frame.minX + 100, y: frame.minY + 100)
        addChild(cloneButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if node.name == "clone" {
                player.clone()
            }
        }
    }

    // Game Loop
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
