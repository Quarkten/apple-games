import SpriteKit

class HUD: SKNode {
    private var healthLabel: SKLabelNode!
    private var resourcesLabel: SKLabelNode!
    private var objectiveLabel: SKLabelNode!

    override init() {
        super.init()

        // Create health label
        healthLabel = SKLabelNode(fontNamed: "Chalkduster")
        healthLabel.text = "Health: 100"
        healthLabel.fontSize = 24
        healthLabel.position = CGPoint(x: 100, y: 50)
        addChild(healthLabel)

        // Create resources label
        resourcesLabel = SKLabelNode(fontNamed: "Chalkduster")
        resourcesLabel.text = "Resources: 1000"
        resourcesLabel.fontSize = 24
        resourcesLabel.position = CGPoint(x: 300, y: 50)
        addChild(resourcesLabel)

        // Create objective label
        objectiveLabel = SKLabelNode(fontNamed: "Chalkduster")
        objectiveLabel.text = "Objective: Defeat all enemies"
        objectiveLabel.fontSize = 24
        objectiveLabel.position = CGPoint(x: 600, y: 50)
        addChild(objectiveLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateHealth(_ health: Int) {
        healthLabel.text = "Health: \(health)"
    }

    func updateResources(_ resources: Int) {
        resourcesLabel.text = "Resources: \(resources)"
    }

    func updateObjective(_ objective: String) {
        objectiveLabel.text = "Objective: \(objective)"
    }
}
