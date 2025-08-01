import Foundation

class ArmyManager {
    // Properties
    static let shared = ArmyManager()
    var clones: [PlayerClone] = []

    // Private init for singleton
    private init() {}

    // Methods
    func addClone(_ clone: PlayerClone) {
        clones.append(clone)
    }

    func upgradeArmy() {
        // Logic to upgrade the entire army
    }
}
