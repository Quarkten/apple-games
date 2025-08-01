import SpriteKit

class LobbyScene: SKScene {
    private var playerLabels: [String: SKLabelNode] = [:]
    private var startButton: SKLabelNode!

    override func didMove(to view: SKView) {
        // In a real game, you would get the list of players from the MultiplayerManager
        let players = ["Player 1", "Player 2"]
        let isHost = true // In a real game, this would be determined by the MultiplayerManager

        for (index, player) in players.enumerated() {
            let playerLabel = SKLabelNode(fontNamed: "Chalkduster")
            playerLabel.text = player
            playerLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100 - CGFloat(index * 50))
            playerLabels[player] = playerLabel
            addChild(playerLabel)
        }

        if isHost {
            startButton = SKLabelNode(fontNamed: "Chalkduster")
            startButton.text = "Start Game"
            startButton.name = "start_game"
            startButton.position = CGPoint(x: frame.midX, y: frame.minY + 100)
            addChild(startButton)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if node.name == "start_game" {
                // Start the game
            }
        }
    }
}
