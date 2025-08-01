import SpriteKit

class MissionSelectionScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Select a Mission"
        titleLabel.fontSize = 48
        titleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(titleLabel)

        // In a real game, you would get the list of missions from the MissionManager
        let missions = [
            (1, "First Encounter"),
            (2, "The Nest"),
            (3, "Tank Attack")
        ]

        for (index, mission) in missions.enumerated() {
            let missionButton = SKLabelNode(fontNamed: "Chalkduster")
            missionButton.text = "Mission \(mission.0): \(mission.1)"
            missionButton.name = "mission_\(mission.0)"
            missionButton.position = CGPoint(x: frame.midX, y: frame.maxY - 200 - CGFloat(index * 100))
            addChild(missionButton)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "mission_") {
                let missionID = Int(nodeName.replacingOccurrences(of: "mission_", with: ""))!
                // Start the selected mission
                let newScene = GameScene(size: self.size)
                // You would need to set the current mission in the MissionManager here
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene)
            }
        }
    }
}
