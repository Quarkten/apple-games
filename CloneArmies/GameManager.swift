import Foundation

class GameManager {
    // Properties
    static let shared = GameManager()
    var missionProgress: Int = 0
    var resources: Int = 1000

    // Private init for singleton
    private init() {}

    // Methods
    func advanceMission() {
        missionProgress += 1
    }

    func spendResources(_ amount: Int) -> Bool {
        if resources >= amount {
            resources -= amount
            return true
        }
        return false
    }

    func addResources(_ amount: Int) {
        resources += amount
    }

    func handleMultiplayer() {
        // Handle multiplayer logic
    }
}
