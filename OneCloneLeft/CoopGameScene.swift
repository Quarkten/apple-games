import SpriteKit

class CoopGameScene: SKScene {
    private var players: [String: Player] = [:]

    override func didMove(to view: SKView) {
        MultiplayerManager.shared.receivedDataHandler = { [weak self] data, peerID in
            self?.handleReceivedData(data)
        }
        MultiplayerManager.shared.connectionStateChangedHandler = { [weak self] peerID, state in
            if state == .notConnected {
                if let player = self?.players.values.first(where: { $0.name == peerID.displayName }) {
                    player.removeFromParent()
                    self?.players.removeValue(forKey: peerID.displayName)
                }
            }
        }
    }

    func handleReceivedData(_ data: Data) {
        do {
            let gameState = try JSONDecoder().decode(GameState.self, from: data)
            let currentPlayers = players
            for playerState in gameState.players {
                if let player = currentPlayers[playerState.id] {
                    // Update existing player
                    player.position = playerState.position
                    player.health = playerState.health
                    // Update weapon and clones
                } else {
                    // Create new player
                    let newPlayer = Player(texture: nil, color: .red, size: CGSize(width: 50, height: 50))
                    newPlayer.position = playerState.position
                    newPlayer.name = playerState.id
                    players[playerState.id] = newPlayer
                    addChild(newPlayer)
                }
            }
        } catch {
            print("Error decoding game state: \(error)")
        }
    }

    func sendGameState() {
        var playerStates: [PlayerState] = []
        for (id, player) in players {
            var cloneStates: [CloneState] = []
            for clone in player.clones {
                cloneStates.append(CloneState(position: clone.position, health: clone.health))
            }
            let weaponState: WeaponState? = nil // To be implemented
            let playerState = PlayerState(id: id, position: player.position, health: player.health, weapon: weaponState, clones: cloneStates)
            playerStates.append(playerState)
        }
        let gameState = GameState(players: playerStates)
        let data = try! JSONEncoder().encode(gameState)
        MultiplayerManager.shared.send(data: data)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if let myPlayer = players["self"] {
            myPlayer.position = location
        } else {
            let myPlayer = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
            myPlayer.position = location
            myPlayer.name = "self"
            players["self"] = myPlayer
            addChild(myPlayer)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        sendGameState()
    }
}
