import Foundation

class Troop {
    // Properties
    var level: Int = 1
    var attackPower: Int = 10
    var defense: Int = 5
    var trainingCost: Int

    // Initializer
    init() {
        self.trainingCost = 50 * level
    }

    // Methods
    func upgrade() {
        level += 1
        attackPower += 5
        defense += 2
        trainingCost = 50 * level
    }
}
