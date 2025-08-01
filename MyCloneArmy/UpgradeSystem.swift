import Foundation

class UpgradeSystem {
    // Properties
    static let shared = UpgradeSystem()
    var coins: Int = 0

    // Private init for singleton
    private init() {}

    // Methods
    func addCoins(_ amount: Int) {
        coins += amount
    }

    func spendCoins(_ amount: Int) -> Bool {
        if coins >= amount {
            coins -= amount
            return true
        }
        return false
    }
}
