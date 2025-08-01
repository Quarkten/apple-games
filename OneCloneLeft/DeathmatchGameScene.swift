import SpriteKit

class DeathmatchGameScene: SKScene {
    private var players: [String: Player] = [:]
    private var score: [String: Int] = [:]

    override func didMove(to view: SKView) {
        MultiplayerManager.shared.receivedDataHandler = { [weak self] data in
            self?.handleReceivedData(data)
        }
    }

    func handleReceivedData(_ data: Data) {
        // In a real game, you would have a more robust way of identifying players
        // and synchronizing their state.
        // This could include player positions, health, attacks, etc.
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if let myPlayer = players["self"] {
            myPlayer.position = location
            // Send updated position to other players
        } else {
            let myPlayer = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
            myPlayer.position = location
            myPlayer.name = "self"
            players["self"] = myPlayer
            score["self"] = 0
            addChild(myPlayer)
        }
    }

    func playerKilled(_ killer: Player, victim: Player) {
        if let killerName = killer.name {
            score[killerName, default: 0] += 1
        }
        victim.removeFromParent()
    }
}
