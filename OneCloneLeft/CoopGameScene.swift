import SpriteKit

class CoopGameScene: SKScene {
    private var players: [String: Player] = [:]

    override func didMove(to view: SKView) {
        MultiplayerManager.shared.receivedDataHandler = { [weak self] data in
            self?.handleReceivedData(data)
        }
    }

    func handleReceivedData(_ data: Data) {
        // In a real game, you would have a more robust way of identifying players
        // and synchronizing their state. For now, I'll just assume the data is
        // the position of the other player.
        do {
            let position = try JSONDecoder().decode(CGPoint.self, from: data)
            if let otherPlayer = players.values.first(where: { $0.name != "self" }) {
                otherPlayer.position = position
            } else {
                let newPlayer = Player(texture: nil, color: .red, size: CGSize(width: 50, height: 50))
                newPlayer.position = position
                newPlayer.name = "other"
                players["other"] = newPlayer
                addChild(newPlayer)
            }
        } catch {
            print("Error decoding position: \(error)")
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if let myPlayer = players["self"] {
            myPlayer.position = location
            let positionData = try! JSONEncoder().encode(location)
            MultiplayerManager.shared.send(data: positionData)
        } else {
            let myPlayer = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
            myPlayer.position = location
            myPlayer.name = "self"
            players["self"] = myPlayer
            addChild(myPlayer)
        }
    }
}
