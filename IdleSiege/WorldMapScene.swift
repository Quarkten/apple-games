import SpriteKit

class WorldMapScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "world_map_background.png")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)

        // Create island nodes
        let island1 = SKShapeNode(circleOfRadius: 50)
        island1.name = "island_1"
        island1.position = CGPoint(x: frame.midX - 150, y: frame.midY)
        island1.fillColor = .green
        addChild(island1)

        let island2 = SKShapeNode(circleOfRadius: 50)
        island2.name = "island_2"
        island2.position = CGPoint(x: frame.midX + 150, y: frame.midY)
        island2.fillColor = .green
        addChild(island2)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name {
                if nodeName.starts(with: "island_") {
                    let islandStrength = 100 // For now, all islands have the same strength
                    let playerStrength = calculatePlayerStrength()
                    if playerStrength > islandStrength {
                        print("You won the battle!")
                        // Mark the island as conquered
                        if let island = node as? SKShapeNode {
                            island.fillColor = .blue
                        }
                    } else {
                        print("You lost the battle!")
                    }
                }
            }
        }
    }

    func calculatePlayerStrength() -> Int {
        // This should be based on the player's troops
        return 150 // For now, the player is always stronger
    }
}
