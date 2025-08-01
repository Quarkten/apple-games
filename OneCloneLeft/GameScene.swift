import SpriteKit

class GameScene: SKScene {
    // Properties
    private var player: PlayerClone?
    private var clones: [PlayerClone] = []
    private var enemies: [SKSpriteNode] = []

    // Scene Lifecycle
    override func didMove(to view: SKView) {
        // Setup scene
    }

    // Game Loop
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
