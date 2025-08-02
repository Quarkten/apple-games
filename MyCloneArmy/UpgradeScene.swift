import SpriteKit

class UpgradeScene: SKScene {
    override func didMove(to view: SKView) {
        // Create upgrade buttons
        for (index, upgrade) in upgradeData.values.enumerated() {
            let upgradeButton = SKLabelNode(fontNamed: "Chalkduster")
            upgradeButton.text = upgrade.name
            upgradeButton.name = "\(upgrade.type)"
            upgradeButton.position = CGPoint(x: frame.midX, y: frame.maxY - 100 - CGFloat(index * 100))
            addChild(upgradeButton)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, let upgradeType = UpgradeType(rawValue: nodeName) {
                UpgradeSystem.shared.upgrade(upgradeType)
            }
        }
    }
}
