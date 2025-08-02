import SpriteKit

class BuildingUpgradeScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Upgrade Buildings"
        titleLabel.fontSize = 48
        titleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(titleLabel)

        // In a real game, you would get the list of buildings from the Base
        let buildings = [
            ("Barracks", 1),
            ("Resource Generator", 2),
            ("Academy", 1)
        ]

        for (index, building) in buildings.enumerated() {
            let buildingLabel = SKLabelNode(fontNamed: "Chalkduster")
            buildingLabel.text = "\(building.0) - Level \(building.1)"
            buildingLabel.name = "upgrade_\(building.0.lowercased())"
            buildingLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 200 - CGFloat(index * 100))
            addChild(buildingLabel)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "upgrade_") {
                // let buildingType = nodeName.replacingOccurrences(of: "upgrade_", with: "")
                // In a real game, you would upgrade the selected building
                print("Upgrading \(nodeName)...")
            }
        }
    }
}
