import SpriteKit

class MultiplayerGameScene: SKScene {
    private var player1: Player?
    private var player2: Player?

    override func didMove(to view: SKView) {
        player1 = Player(texture: nil, color: .blue, size: CGSize(width: 50, height: 50), gameScene: nil)
        player1?.position = CGPoint(x: frame.minX + 100, y: frame.midY)
        addChild(player1!)

        player2 = Player(texture: nil, color: .red, size: CGSize(width: 50, height: 50), gameScene: nil)
        player2?.position = CGPoint(x: frame.maxX - 100, y: frame.midY)
        addChild(player2!)

        MultiplayerManager.shared.receivedDataHandler = { [weak self] data in
            self?.handleReceivedData(data)
        }
    }

    func handleReceivedData(_ data: Data) {
        do {
            let gameState = try JSONDecoder().decode(GameState.self, from: data)
            player2?.position = gameState.playerPosition
        } catch {
            print("Error decoding game state: \(error)")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        player1?.move(to: location)

        let gameState = GameState(playerPosition: location)
        let data = try! JSONEncoder().encode(gameState)
        MultiplayerManager.shared.send(data: data)
    }
}
