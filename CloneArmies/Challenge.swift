import Foundation

struct Challenge {
    let challengeID: Int
    let title: String
    let description: String
    let objective: ChallengeObjective
    let reward: Int
}

enum ChallengeObjective {
    case survive(duration: TimeInterval)
    case defeatEnemies(count: Int)
}
