import SpriteKit

class SpriteManager {
    static let shared = SpriteManager()

    private var cloneTexture: SKTexture?
    private var weaponTexture: SKTexture?

    private init() {
        // In a real game, you would load these textures from a texture atlas
        // For now, I'll just create some placeholder textures
        cloneTexture = SKTexture(imageNamed: "clone.png")
        weaponTexture = SKTexture(imageNamed: "weapon.png")
    }

    func getCloneTexture() -> SKTexture? {
        return cloneTexture
    }

    func getWeaponTexture() -> SKTexture? {
        return weaponTexture
    }
}
