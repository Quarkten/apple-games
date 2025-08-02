import SpriteKit

class CampaignScene: SKScene {
    override func didMove(to view: SKView) {
        // In a real game, you would display a map with mission nodes
        // For now, I'll just create a simple list of missions
        let missions = [
            "First Battle",
            "Second Wave"
        ]

        for (index, mission) in missions.enumerated() {
            let missionButton = SKLabelNode(fontNamed: "Chalkduster")
            missionButton.text = mission
            missionButton.name = "mission_\(index)"
            missionButton.position = CGPoint(x: frame.midX, y: frame.maxY - 100 - CGFloat(index * 100))
            addChild(missionButton)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "mission_") {
                // let missionIndex = Int(nodeName.replacingOccurrences(of: "mission_", with: ""))!
                // In a real game, you would set the current mission in the MissionManager
                // and then transition to the MultiplayerBattleScene
                let newScene = MultiplayerBattleScene(size: self.size)
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene)
            }
        }
    }
}
