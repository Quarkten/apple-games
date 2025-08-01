import SpriteKit

class Player: SKSpriteNode {
    func clone() {
        let clone = PlayerClone(texture: self.texture, color: self.color, size: self.size)
        clone.position = self.position
        ArmyManager.shared.addClone(clone)
        self.parent?.addChild(clone)
    }
}
