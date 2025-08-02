import Foundation

enum MissionObjective {
    case defeatAllEnemies
    case survive(duration: TimeInterval)
    case escort(npc: NPC)
}

class NPC: SKSpriteNode {
    // An NPC that the player might need to escort
}

struct Mission {
    let title: String
    let description: String
    let objective: MissionObjective
    let enemyWaves: [[Enemy.Type]]
    let reward: [String: Int]
}
