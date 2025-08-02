import SpriteKit

class WorldMapScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "world_map_background.png")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)

        // Create island nodes
        let island1 = Island(difficulty: 1)
        island1.name = "island_1"
        island1.position = CGPoint(x: frame.midX - 150, y: frame.midY)
        addChild(island1)

        let island2 = Island(difficulty: 2)
        island2.name = "island_2"
        island2.position = CGPoint(x: frame.midX + 150, y: frame.midY)
        addChild(island2)

        let island3 = Island(difficulty: 3)
        island3.name = "island_3"
        island3.position = CGPoint(x: frame.midX, y: frame.midY + 150)
        addChild(island3)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let island = node as? Island {
                let islandStrength = island.difficulty * 100
                let playerStrength = calculatePlayerStrength()
                if playerStrength > islandStrength {
                    print("You won the battle!")
                    // Mark the island as conquered
                    island.fillColor = .blue
                } else {
                    print("You lost the battle!")
                }
            }
        }
    }

    func calculatePlayerStrength() -> Int {
        // This should be based on the player's troops
        return 150 // For now, the player is always stronger
    }
}
