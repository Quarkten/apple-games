import SpriteKit

class AllianceScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Alliances"
        titleLabel.fontSize = 64
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        addChild(titleLabel)

        if let myAlliance = AllianceManager.shared.getMyAlliance() {
            // Display my alliance info
            let myAllianceLabel = SKLabelNode(fontNamed: "Chalkduster")
            myAllianceLabel.text = "My Alliance: \(myAlliance.name)"
            myAllianceLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
            addChild(myAllianceLabel)

            let leaveButton = SKLabelNode(fontNamed: "Chalkduster")
            leaveButton.text = "Leave Alliance"
            leaveButton.name = "leave_alliance"
            leaveButton.position = CGPoint(x: frame.midX, y: frame.midY)
            addChild(leaveButton)
        } else {
            // Display list of alliances to join
            let alliances = AllianceManager.shared.getAlliances()
            for (index, alliance) in alliances.enumerated() {
                let allianceButton = SKLabelNode(fontNamed: "Chalkduster")
                allianceButton.text = "\(alliance.name) (\(alliance.members.count) members)"
                allianceButton.name = "join_\(alliance.name)"
                allianceButton.position = CGPoint(x: frame.midX, y: frame.midY - CGFloat(index * 100))
                addChild(allianceButton)
            }

            let createButton = SKLabelNode(fontNamed: "Chalkduster")
            createButton.text = "Create Alliance"
            createButton.name = "create_alliance"
            createButton.position = CGPoint(x: frame.midX, y: frame.minY + 100)
            addChild(createButton)
        }
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
        if name.starts(with: "join_") {
            let allianceName = name.replacingOccurrences(of: "join_", with: "")
            if let alliance = AllianceManager.shared.getAlliances().first(where: { $0.name == allianceName }) {
                AllianceManager.shared.joinAlliance(alliance)
                // Reload the scene
            }
        } else {
            switch name {
            case "create_alliance":
                // In a real game, you would show a text input field to enter the alliance name
                AllianceManager.shared.createAlliance(name: "My New Alliance")
                // Reload the scene
            case "leave_alliance":
                AllianceManager.shared.leaveAlliance()
                // Reload the scene
            default:
                break
            }
        }
    }
}
