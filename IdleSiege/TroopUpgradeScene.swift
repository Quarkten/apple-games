import SpriteKit

class TroopUpgradeScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Upgrade Troops"
        titleLabel.fontSize = 48
        titleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(titleLabel)

        // In a real game, you would get the list of troops from the Base
        let troops = [
            ("Swordsman", 1),
            ("Archer", 1)
        ]

        for (index, troop) in troops.enumerated() {
            let troopLabel = SKLabelNode(fontNamed: "Chalkduster")
            troopLabel.text = "\(troop.0) - Level \(troop.1)"
            troopLabel.name = "upgrade_\(troop.0.lowercased())"
            troopLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 200 - CGFloat(index * 100))
            addChild(troopLabel)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "upgrade_") {
                // let troopType = nodeName.replacingOccurrences(of: "upgrade_", with: "")
                // In a real game, you would upgrade the selected troop
                print("Upgrading \(nodeName)...")
            }
        }
    }
}
