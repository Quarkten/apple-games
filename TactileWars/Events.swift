import SpriteKit

class TreasureChest: SKShapeNode {
    let resources: [ResourceType: Int]

    init(resources: [ResourceType: Int]) {
        self.resources = resources
        super.init()
        self.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 40, height: 40)).cgPath
        self.fillColor = .purple
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Rebellion {
    let territory: Territory
    let strength: Int

    init(territory: Territory, strength: Int) {
        self.territory = territory
        self.strength = strength
    }
}
