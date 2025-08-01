import Foundation

class Troop {
    // Properties
    var level: Int = 1
    var attackPower: Int = 10
    var defense: Int = 5

    // Methods
    func upgrade() {
        level += 1
        attackPower += 5
        defense += 2
    }
}
