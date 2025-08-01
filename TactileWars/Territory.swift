import SpriteKit

class Territory: SKShapeNode {
    // Properties
    var owner: Player?

    // Initializer
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Methods
    func conquer(by player: Player) {
        self.owner = player
        self.fillColor = player.color
    }
}
