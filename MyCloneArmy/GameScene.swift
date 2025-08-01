import SpriteKit

class GameScene: SKScene {
    private var player: Player!

    override func didMove(to view: SKView) {
        player = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(player)

        let cloneButton = SKLabelNode(fontNamed: "Chalkduster")
        cloneButton.text = "Clone"
        cloneButton.name = "clone"
        cloneButton.position = CGPoint(x: frame.minX + 100, y: frame.minY + 100)
        addChild(cloneButton)

        let battleButton = SKLabelNode(fontNamed: "Chalkduster")
        battleButton.text = "Battle"
        battleButton.name = "battle"
        battleButton.position = CGPoint(x: frame.maxX - 100, y: frame.minY + 100)
        addChild(battleButton)

        let upgradeButton = SKLabelNode(fontNamed: "Chalkduster")
        upgradeButton.text = "Upgrades"
        upgradeButton.name = "upgrades"
        upgradeButton.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        addChild(upgradeButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if node.name == "clone" {
                player.clone()
            } else if node.name == "battle" {
                let newScene = MultiplayerBattleScene(size: self.size)
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene)
            } else if node.name == "upgrades" {
                let newScene = UpgradeScene(size: self.size)
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene)
            }
        }
    }
}
