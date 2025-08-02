import Foundation

class UpgradeSystem {
    // Properties
    static let shared = UpgradeSystem()
    var coins: Int = 0
    private var upgradeLevels: [UpgradeType: Int] = [:]

    // Private init for singleton
    private init() {
        for upgradeType in upgradeData.keys {
            upgradeLevels[upgradeType] = 1
        }
    }

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

    func getUpgradeLevel(for type: UpgradeType) -> Int {
        return upgradeLevels[type] ?? 1
    }

    func upgrade(_ type: UpgradeType) {
        if let data = upgradeData[type] {
            let cost = data.baseCost * (upgradeLevels[type] ?? 1)
            if spendCoins(cost) {
                upgradeLevels[type, default: 1] += 1
                print("\(data.name) upgraded to level \(upgradeLevels[type]!)!")
            } else {
                print("Not enough coins to upgrade \(data.name)!")
            }
        }
    }
}
