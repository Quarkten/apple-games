import SpriteKit

class BaseScene: SKScene {
    private var base: Base!
    private var goldLabel: SKLabelNode!
    private var woodLabel: SKLabelNode!
    private var stoneLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.png")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)

        base = Base()
        setupUI()
    }

    func setupUI() {
        // Create resource labels
        goldLabel = SKLabelNode(fontNamed: "Chalkduster")
        goldLabel.position = CGPoint(x: 100, y: frame.maxY - 50)
        addChild(goldLabel)

        woodLabel = SKLabelNode(fontNamed: "Chalkduster")
        woodLabel.position = CGPoint(x: 300, y: frame.maxY - 50)
        addChild(woodLabel)

        stoneLabel = SKLabelNode(fontNamed: "Chalkduster")
        stoneLabel.position = CGPoint(x: 500, y: frame.maxY - 50)
        addChild(stoneLabel)

        updateResourceLabel()

        // Create build buttons
        let buildBarracksButton = SKLabelNode(fontNamed: "Chalkduster")
        buildBarracksButton.text = "Build Barracks"
        buildBarracksButton.name = "build_barracks"
        buildBarracksButton.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        addChild(buildBarracksButton)

        let buildGeneratorButton = SKLabelNode(fontNamed: "Chalkduster")
        buildGeneratorButton.text = "Build Generator"
        buildGeneratorButton.name = "build_generator"
        buildGeneratorButton.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        addChild(buildGeneratorButton)

        let trainTroopButton = SKLabelNode(fontNamed: "Chalkduster")
        trainTroopButton.text = "Train Troop"
        trainTroopButton.name = "train_troop"
        trainTroopButton.position = CGPoint(x: frame.midX, y: frame.midY - 150)
        addChild(trainTroopButton)

        let buildAcademyButton = SKLabelNode(fontNamed: "Chalkduster")
        buildAcademyButton.text = "Build Academy"
        buildAcademyButton.name = "build_academy"
        buildAcademyButton.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(buildAcademyButton)

        let trainSwordsmanButton = SKLabelNode(fontNamed: "Chalkduster")
        trainSwordsmanButton.text = "Train Swordsman"
        trainSwordsmanButton.name = "train_swordsman"
        trainSwordsmanButton.position = CGPoint(x: frame.midX, y: frame.midY - 250)
        addChild(trainSwordsmanButton)

        let worldMapButton = SKLabelNode(fontNamed: "Chalkduster")
        worldMapButton.text = "World Map"
        worldMapButton.name = "world_map"
        worldMapButton.position = CGPoint(x: frame.midX, y: frame.midY - 250)
        addChild(worldMapButton)

        let pvpButton = SKLabelNode(fontNamed: "Chalkduster")
        pvpButton.text = "PvP Battle"
        pvpButton.name = "pvp_battle"
        pvpButton.position = CGPoint(x: frame.midX, y: frame.midY - 350)
        addChild(pvpButton)

        let allianceButton = SKLabelNode(fontNamed: "Chalkduster")
        allianceButton.text = "Alliance"
        allianceButton.name = "alliance"
        allianceButton.position = CGPoint(x: frame.midX, y: frame.midY - 400)
        addChild(allianceButton)

        let leaderboardButton = SKLabelNode(fontNamed: "Chalkduster")
        leaderboardButton.text = "Leaderboard"
        leaderboardButton.name = "leaderboard"
        leaderboardButton.position = CGPoint(x: frame.midX, y: frame.midY - 450)
        addChild(leaderboardButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if let nodeName = node.name {
                handleButtonPress(name: nodeName)
            }
        }
    }

    func handleButtonPress(name: String) {
        let building: Building
        switch name {
        case "build_barracks":
            building = Barracks()
        case "build_generator":
            building = ResourceGenerator()
        case "train_troop":
            let troop = Troop(type: .swordsman) // Default to swordsman for now
            var canAfford = true
            for (resource, amount) in troop.trainingCost {
                if !ResourceManager.shared.spendResource(amount, type: resource) {
                    canAfford = false
                    break
                }
            }

            if canAfford {
                base.addTroop(troop)
                print("Trained a troop!")
                updateResourceLabel()
            } else {
                print("Not enough resources!")
                // Refund the spent resources
                for (resource, amount) in troop.trainingCost {
                    ResourceManager.shared.addResource(amount, type: resource)
                }
            }
            return
        case "build_academy":
            building = Academy()
        case "train_swordsman":
            let troop = Swordsman()
            if ResourceManager.shared.spendResource(troop.trainingCost, type: .gold) {
                base.addTroop(troop)
                print("Trained a swordsman!")
                updateResourceLabel()
            } else {
                print("Not enough gold!")
            }
            return
        case "world_map":
            let newScene = WorldMapScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
            return
        case "pvp_battle":
            let newScene = PvPScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
            return
        case "alliance":
            let newScene = AllianceScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
            return
        case "leaderboard":
            let newScene = LeaderboardScene(size: self.size)
            newScene.scaleMode = .aspectFill
            view?.presentScene(newScene)
            return
        default:
            return
        }

        var canAfford = true
        for (resource, amount) in building.cost {
            if ResourceManager.shared.getResourceAmount(for: resource) < amount {
                canAfford = false
                break
            }
        }

        if canAfford {
            for (resource, amount) in building.cost {
                ResourceManager.shared.spendResource(amount, type: resource)
            }
            base.addBuilding(building)
            building.build()
            print("Built a \(building.type)!")
        } else {
            print("Not enough resources!")
        }
        updateResourceLabel()
    }

    func updateResourceLabel() {
        goldLabel.text = "Gold: \(ResourceManager.shared.getResourceAmount(for: .gold))"
        woodLabel.text = "Wood: \(ResourceManager.shared.getResourceAmount(for: .wood))"
        stoneLabel.text = "Stone: \(ResourceManager.shared.getResourceAmount(for: .stone))"
    }
}
