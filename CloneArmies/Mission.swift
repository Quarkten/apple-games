import Foundation

enum MissionObjectiveType {
    case defeatAllEnemies
    case survive(duration: TimeInterval)
    case defeatBoss
}

struct Mission {
    let missionID: Int
    let title: String
    let objective: MissionObjectiveType
    let enemyTypes: [TroopType]
    let reward: Int
}
