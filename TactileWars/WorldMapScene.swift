import SpriteKit

class WorldMapScene: SKScene {
    override func didMove(to view: SKView) {
        // Create territory nodes
        let territory1 = Territory()
        territory1.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 150)).cgPath
        territory1.fillColor = .lightGray
        territory1.name = "territory_1"
        addChild(territory1)

        let territory2 = Territory()
        territory2.path = UIBezierPath(rect: CGRect(x: 400, y: 300, width: 200, height: 150)).cgPath
        territory2.fillColor = .lightGray
        territory2.name = "territory_2"
        addChild(territory2)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name, nodeName.starts(with: "territory_") {
                if let territory = node as? Territory {
                    let player = Player(name: "Player 1", color: .blue)
                    let enemyTroops = 5 // For now, the enemy always has 5 troops
                    let playerTroops = 10 // For now, the player always has 10 troops

                    if playerTroops > enemyTroops {
                        print("You conquered the territory!")
                        territory.conquer(by: player)
                    } else {
                        print("You lost the battle!")
                    }
                }
            }
        }
    }
}
