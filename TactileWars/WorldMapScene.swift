import SpriteKit

class WorldMapScene: SKScene {
    private var aiPlayers: [Player] = []

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "world_map_background.png")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)

        // Create AI players
        aiPlayers.append(Player(name: "AI 1", color: .red))
        aiPlayers.append(Player(name: "AI 2", color: .green))

        // Create territory nodes
        let territory1 = Territory()
        territory1.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 150)).cgPath
        territory1.name = "territory_1"
        territory1.conquer(by: aiPlayers[0])
        addChild(territory1)

        let territory2 = Territory()
        territory2.path = UIBezierPath(rect: CGRect(x: 400, y: 300, width: 200, height: 150)).cgPath
        territory2.name = "territory_2"
        territory2.conquer(by: aiPlayers[1])
        addChild(territory2)

        let goldNode = ResourceNode(type: .gold, amount: 100)
        goldNode.position = CGPoint(x: 300, y: 200)
        addChild(goldNode)

        let woodNode = ResourceNode(type: .wood, amount: 50)
        woodNode.position = CGPoint(x: 500, y: 400)
        addChild(woodNode)

        let legend = WorldMapLegend()
        legend.position = CGPoint(x: frame.maxX - 120, y: frame.maxY - 100)
        addChild(legend)
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
            } else if let resourceNode = node as? ResourceNode {
                // In a real game, you would add the resources to the player's inventory
                print("You captured a resource node with \(resourceNode.amount) \(resourceNode.type)!")
                resourceNode.removeFromParent()
            }
        }
    }


    override func update(_ currentTime: TimeInterval) {
        // AI attacks
        if Int.random(in: 0...1000) < 5 {
            let attackingAI = aiPlayers.randomElement()!
            let targetableTerritories = self.children.compactMap { $0 as? Territory }.filter { $0.owner !== attackingAI }
            if let targetTerritory = targetableTerritories.randomElement() {
                print("\(attackingAI.name) is attacking \(targetTerritory.owner?.name ?? "a neutral") territory!")
                let enemyTroops = 5 // For now, the enemy always has 5 troops
                let aiTroops = 7 // For now, the AI always has 7 troops
                if aiTroops > enemyTroops {
                    print("\(attackingAI.name) conquered the territory!")
                    targetTerritory.conquer(by: attackingAI)
                } else {
                    print("\(attackingAI.name) lost the battle!")
                }
            }
        }

        // Treasure chests
        if Int.random(in: 0...1000) < 2 {
            let resources: [ResourceType: Int] = [.gold: Int.random(in: 50...200)]
            let treasureChest = TreasureChest(resources: resources)
            let randomX = CGFloat.random(in: self.frame.minX...self.frame.maxX)
            let randomY = CGFloat.random(in: self.frame.minY...self.frame.maxY)
            treasureChest.position = CGPoint(x: randomX, y: randomY)
            addChild(treasureChest)
        }

        // Rebellions
        if Int.random(in: 0...2000) < 1 {
            if let territory = self.children.compactMap({ $0 as? Territory }).randomElement() {
                let rebellion = Rebellion(territory: territory, strength: 10)
                print("A rebellion has started in \(territory.name!)!")
            }
        }
    }
}
