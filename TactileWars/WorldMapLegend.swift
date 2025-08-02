import SpriteKit

class WorldMapLegend: SKNode {
    override init() {
        super.init()

        let background = SKShapeNode(rectOf: CGSize(width: 200, height: 150))
        background.fillColor = .white
        background.alpha = 0.8
        addChild(background)

        let playerTerritory = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        playerTerritory.fillColor = .blue
        playerTerritory.position = CGPoint(x: -80, y: 50)
        addChild(playerTerritory)

        let playerTerritoryLabel = SKLabelNode(fontNamed: "Chalkduster")
        playerTerritoryLabel.text = "Your Territory"
        playerTerritoryLabel.fontSize = 16
        playerTerritoryLabel.position = CGPoint(x: 0, y: 45)
        addChild(playerTerritoryLabel)

        let enemyTerritory = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        enemyTerritory.fillColor = .red
        enemyTerritory.position = CGPoint(x: -80, y: 0)
        addChild(enemyTerritory)

        let enemyTerritoryLabel = SKLabelNode(fontNamed: "Chalkduster")
        enemyTerritoryLabel.text = "Enemy Territory"
        enemyTerritoryLabel.fontSize = 16
        enemyTerritoryLabel.position = CGPoint(x: 0, y: -5)
        addChild(enemyTerritoryLabel)

        let resourceNode = ResourceNode(type: .gold, amount: 0)
        resourceNode.position = CGPoint(x: -80, y: -50)
        addChild(resourceNode)

        let resourceNodeLabel = SKLabelNode(fontNamed: "Chalkduster")
        resourceNodeLabel.text = "Resource Node"
        resourceNodeLabel.fontSize = 16
        resourceNodeLabel.position = CGPoint(x: 0, y: -55)
        addChild(resourceNodeLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
