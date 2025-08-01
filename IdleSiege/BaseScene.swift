import SpriteKit

class BaseScene: SKScene {
    private var base: Base!
    private var resourceLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        base = Base()
        setupUI()
    }

    func setupUI() {
        // Create resource label
        resourceLabel = SKLabelNode(fontNamed: "Chalkduster")
        resourceLabel.text = "Gold: \(ResourceManager.shared.gold)"
        resourceLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        addChild(resourceLabel)

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
            let troop = Troop()
            if ResourceManager.shared.spendGold(troop.trainingCost) {
                base.addTroop(troop)
                print("Trained a troop!")
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
        default:
            return
        }

        if ResourceManager.shared.spendGold(building.cost) {
            base.addBuilding(building)
            print("Built a \(building.type)!")
            updateResourceLabel()
        } else {
            print("Not enough gold!")
        }
    }

    func updateResourceLabel() {
        resourceLabel.text = "Gold: \(ResourceManager.shared.gold)"
    }
}
