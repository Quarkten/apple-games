import Foundation

struct DefenseData {
    let type: DefenseType
    let name: String
    let cost: Int
    let health: Int
    let damage: Int
}

let defenseData: [DefenseType: DefenseData] = [
    .mine: DefenseData(type: .mine, name: "Mine", cost: 50, health: 10, damage: 100),
    .tank: DefenseData(type: .tank, name: "Tank", cost: 200, health: 300, damage: 20),
    .cannon: DefenseData(type: .cannon, name: "Cannon", cost: 150, health: 200, damage: 50)
]
