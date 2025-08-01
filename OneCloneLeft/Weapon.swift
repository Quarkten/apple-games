import SpriteKit

class Weapon: SKSpriteNode {
    var damage: Int = 0
    var fireRate: TimeInterval = 0
    var reloadTime: TimeInterval = 0

    func clone() -> WeaponClone {
        let clone = WeaponClone(texture: self.texture, color: self.color, size: self.size)
        // Copy other properties as needed
        return clone
    }

    func fire() {
        // To be implemented
    }
}
