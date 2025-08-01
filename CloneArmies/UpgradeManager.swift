import Foundation

class UpgradeManager {
    static let shared = UpgradeManager()

    private var troopUpgradeLevels: [TroopType: Int] = [:]
    private var weaponUpgradeLevel: Int = 0

    private init() {
        // Initialize with default upgrade levels
        for troopType in [TroopType.sniper, .jetpack, .tank] {
            troopUpgradeLevels[troopType] = 1
        }
    }

    func getTroopUpgradeLevel(for troopType: TroopType) -> Int {
        return troopUpgradeLevels[troopType] ?? 1
    }

    func upgradeTroop(for troopType: TroopType) {
        troopUpgradeLevels[troopType, default: 1] += 1
    }

    func getWeaponUpgradeLevel() -> Int {
        return weaponUpgradeLevel
    }

    func upgradeWeapon() {
        weaponUpgradeLevel += 1
    }
}
