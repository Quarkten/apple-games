import SpriteKit

class SpriteManager {
    static let shared = SpriteManager()

    private var troopTextures: [TroopType: SKTexture] = [:]

    private init() {
        // In a real game, you would load these textures from a texture atlas
        // For now, I'll just create some placeholder textures
        troopTextures[.infantry] = SKTexture(imageNamed: "infantry.png")
        troopTextures[.ranged] = SKTexture(imageNamed: "ranged.png")
        troopTextures[.cavalry] = SKTexture(imageNamed: "cavalry.png")
    }

    func getTexture(for troopType: TroopType) -> SKTexture? {
        return troopTextures[troopType]
    }
}
