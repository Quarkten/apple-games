import SpriteKit

class LobbyBrowserScene: SKScene {
    override func didMove(to view: SKView) {
        // Create title label
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "Lobby Browser"
        titleLabel.fontSize = 48
        titleLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(titleLabel)

        // In a real game, you would get the list of available lobbies from the server
        let lobbies = [
            ("Player 1's Game", "Co-op", 2, 4),
            ("Player 2's Game", "Deathmatch", 3, 6)
        ]

        for (index, lobby) in lobbies.enumerated() {
            let lobbyLabel = SKLabelNode(fontNamed: "Chalkduster")
            lobbyLabel.text = "\(lobby.0) - \(lobby.1) (\(lobby.2)/\(lobby.3))"
            lobbyLabel.name = "lobby_\(index)"
            lobbyLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 200 - CGFloat(index * 100))
            addChild(lobbyLabel)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "lobby_") {
                // let lobbyIndex = Int(nodeName.replacingOccurrences(of: "lobby_", with: ""))!
                // In a real game, you would join the selected lobby
                print("Joining lobby \(nodeName)...")
            }
        }
    }
}
