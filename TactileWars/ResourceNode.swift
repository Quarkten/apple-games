import SpriteKit

enum ResourceType {
    case gold
    case wood
}

class ResourceNode: SKShapeNode {
    let type: ResourceType
    var amount: Int

    init(type: ResourceType, amount: Int) {
        self.type = type
        self.amount = amount
        super.init()
        self.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 30, height: 30)).cgPath
        switch type {
        case .gold:
            self.fillColor = .yellow
        case .wood:
            self.fillColor = .brown
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
