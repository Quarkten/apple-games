import SpriteKit

class PvPScene: SKScene {
    private var opponentBase: Base!
    private var playerTroops: [Troop] = []

    override func didMove(to view: SKView) {
        if let opponent = PvPManager.shared.findOpponent() {
            opponentBase = opponent
        } else {
            // Handle case where no opponent is found
            // For now, just create a dummy opponent
            opponentBase = Base()
            opponentBase.addBuilding(Barracks())
            opponentBase.addBuilding(ResourceGenerator())
        }

        // Get the player's troops
        // playerTroops = getPlayerTroops()

        setupUI()
    }

    func setupUI() {
        // Display the opponent's base
        // ...

        // Create an "Attack" button
        let attackButton = SKLabelNode(fontNamed: "Chalkduster")
        attackButton.text = "Attack"
        attackButton.name = "attack"
        attackButton.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        addChild(attackButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if node.name == "attack" {
                startBattle()
            }
        }
    }

    func startBattle() {
        let playerStrength = calculatePlayerStrength()
        let opponentStrength = calculateOpponentStrength()

        if playerStrength > opponentStrength {
            print("You won the PvP battle!")
        } else {
            print("You lost the PvP battle!")
        }
    }

    func calculatePlayerStrength() -> Int {
        // Based on playerTroops
        return 150
    }

    func calculateOpponentStrength() -> Int {
        // Based on opponentBase.troops
        return 100
    }
}
