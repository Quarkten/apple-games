import SpriteKit

class GameScene: SKScene {
    private var troops: [Troop] = []
    private var pathNode: SKShapeNode?

    override func didMove(to view: SKView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)

        // Create some troops
        for i in 0..<3 {
            let troop = Troop(type: .infantry)
            troop.position = CGPoint(x: 100 + i * 40, y: 100)
            troops.append(troop)
            addChild(troop)
        }
        for i in 0..<2 {
            let troop = Troop(type: .ranged)
            troop.position = CGPoint(x: 100 + i * 40, y: 150)
            troops.append(troop)
            addChild(troop)
        }

        let worldMapButton = SKLabelNode(fontNamed: "Chalkduster")
        worldMapButton.text = "World Map"
        worldMapButton.name = "world_map"
        worldMapButton.position = CGPoint(x: frame.maxX - 100, y: frame.maxY - 50)
        addChild(worldMapButton)

        let leaderboardButton = SKLabelNode(fontNamed: "Chalkduster")
        leaderboardButton.text = "Leaderboard"
        leaderboardButton.name = "leaderboard"
        leaderboardButton.position = CGPoint(x: frame.maxX - 100, y: frame.maxY - 100)
        addChild(leaderboardButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if node.name == "world_map" {
                let newScene = WorldMapScene(size: self.size)
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene)
            } else if node.name == "leaderboard" {
                let newScene = LeaderboardScene(size: self.size)
                newScene.scaleMode = .aspectFill
                view?.presentScene(newScene)
            }
        }
    }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self.view)
        let sceneLocation = convertPoint(fromView: location)

        switch gesture.state {
        case .began:
            pathNode = SKShapeNode()
            pathNode?.strokeColor = .white
            pathNode?.lineWidth = 2.0
            addChild(pathNode!)

            let path = CGMutablePath()
            path.move(to: sceneLocation)
            pathNode?.path = path
        case .changed:
            guard let path = pathNode?.path?.mutableCopy() else { return }
            path.addLine(to: sceneLocation)
            pathNode?.path = path
        case .ended:
            if let path = pathNode?.path {
                for (index, troop) in troops.enumerated() {
                    let offset = CGPoint(x: 0, y: (index - troops.count / 2) * 40)
                    troop.formationOffset = offset
                    troop.walk()
                    troop.move(along: path)
                }
            }
            pathNode?.removeFromParent()
            pathNode = nil
        default:
            break
        }
    }
}
