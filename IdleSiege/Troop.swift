import Foundation

enum TroopType {
    case swordsman
}

class Troop {
    // Properties
    var level: Int = 1
    var attackPower: Int = 10
    var defense: Int = 5
    var trainingCost: [ResourceType: Int]
    var type: TroopType

    // Initializer
    init(type: TroopType) {
        self.type = type
        self.trainingCost = [.gold: 50 * level]
    }

    // Methods
    func upgrade() {
        level += 1
        attackPower += 5
        defense += 2
        trainingCost[.gold] = 50 * level
    }
}

class Swordsman: Troop {
    init() {
        super.init(type: .swordsman)
    }
}
