import Foundation

class UpgradeSystem {
    // Properties
    static let shared = UpgradeSystem()
    var coins: Int = 0
    var weaponUpgradeLevel: Int = 1
    var armyUpgradeLevel: Int = 1
    var healthUpgradeLevel: Int = 1

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

    func upgradeWeapon() {
        let cost = 50 * weaponUpgradeLevel
        if spendCoins(cost) {
            weaponUpgradeLevel += 1
            print("Weapon upgraded to level \(weaponUpgradeLevel)!")
        } else {
            print("Not enough coins to upgrade weapon!")
        }
    }

    func upgradeArmy() {
        let cost = 100 * armyUpgradeLevel
        if spendCoins(cost) {
            armyUpgradeLevel += 1
            print("Army upgraded to level \(armyUpgradeLevel)!")
        } else {
            print("Not enough coins to upgrade army!")
        }
    }

    func upgradeHealth() {
        let cost = 75 * healthUpgradeLevel
        if spendCoins(cost) {
            healthUpgradeLevel += 1
            print("Health upgraded to level \(healthUpgradeLevel)!")
        } else {
            print("Not enough coins to upgrade health!")
        }
    }
}
