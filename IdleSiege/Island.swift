import SpriteKit

class Island: SKShapeNode {
    let difficulty: Int

    init(difficulty: Int) {
        self.difficulty = difficulty
        super.init()
        self.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        self.fillColor = .green
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
