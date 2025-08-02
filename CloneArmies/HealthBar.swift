import SpriteKit

class HealthBar: SKNode {
    private var backgroundNode: SKShapeNode
    private var barNode: SKShapeNode
    private var maxHealth: Int
    private var currentHealth: Int

    init(maxHealth: Int) {
        self.maxHealth = maxHealth
        self.currentHealth = maxHealth

        backgroundNode = SKShapeNode(rectOf: CGSize(width: 50, height: 5))
        backgroundNode.fillColor = .darkGray
        backgroundNode.strokeColor = .clear
        backgroundNode.zPosition = Constants.ZPositions.healthBar

        barNode = SKShapeNode(rectOf: CGSize(width: 50, height: 5))
        barNode.fillColor = .green
        barNode.strokeColor = .clear
        barNode.zPosition = Constants.ZPositions.healthBar + 1

        super.init()

        addChild(backgroundNode)
        addChild(barNode)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(currentHealth: Int) {
        self.currentHealth = currentHealth
        let healthPercentage = CGFloat(currentHealth) / CGFloat(maxHealth)
        barNode.xScale = healthPercentage

        if healthPercentage < 0.3 {
            barNode.fillColor = .red
        } else if healthPercentage < 0.6 {
            barNode.fillColor = .yellow
        } else {
            barNode.fillColor = .green
        }
    }
}
