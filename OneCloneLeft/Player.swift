import SpriteKit

class Player: SKSpriteNode {
    private var clones: [PlayerClone] = []
    var weapon: Weapon?
    var unlockedPerks: [Perk] = []

    func addPerk(_ perk: Perk) {
        unlockedPerks.append(perk)
        perk.effect(self)
    }

    func clone() {
        let clone = PlayerClone(texture: self.texture, color: self.color, size: self.size)
        clone.position = self.position
        if let weapon = self.weapon {
            clone.weapon = weapon.clone()
        }
        self.parent?.addChild(clone)
        clones.append(clone)
    }
}
