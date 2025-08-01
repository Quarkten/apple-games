import Foundation

class ResourceManager {
    // Properties
    static let shared = ResourceManager()
    var gold: Int = 1000
    var cash: Int = 100

    // Private init for singleton
    private init() {}

    // Methods
    func addGold(_ amount: Int) {
        gold += amount
    }

    func spendGold(_ amount: Int) -> Bool {
        if gold >= amount {
            gold -= amount
            return true
        }
        return false
    }

    func addCash(_ amount: Int) {
        cash += amount
    }

    func spendCash(_ amount: Int) -> Bool {
        if cash >= amount {
            cash -= amount
            return true
        }
        return false
    }
}
