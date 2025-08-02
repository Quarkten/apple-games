import Foundation

struct Mission {
    let title: String
    let description: String
    let aiOpponent: AIOpponent
    let reward: [String: Int]
}

struct AIOpponent {
    let army: ArmyState
    // Add other AI properties, e.g., difficulty, strategy
}
