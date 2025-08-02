import Foundation

struct UpgradeData {
    let type: UpgradeType
    let name: String
    let baseCost: Int
}

let upgradeData: [UpgradeType: UpgradeData] = [
    .weaponDamage: UpgradeData(type: .weaponDamage, name: "Weapon Damage", baseCost: 50),
    .weaponFireRate: UpgradeData(type: .weaponFireRate, name: "Weapon Fire Rate", baseCost: 75),
    .armySize: UpgradeData(type: .armySize, name: "Army Size", baseCost: 100),
    .cloneHealth: UpgradeData(type: .cloneHealth, name: "Clone Health", baseCost: 75)
]
