import XCTest
@testable import MyCloneArmy

class MyCloneArmyTests: XCTestCase {

    func testArmyManagerAddClone() {
        let armyManager = ArmyManager.shared
        let clone = PlayerClone()
        armyManager.addClone(clone)
        XCTAssertEqual(armyManager.clones.count, 1)
    }

    func testUpgradeSystemUpgradeWeapon() {
        let upgradeSystem = UpgradeSystem.shared
        upgradeSystem.upgradeWeapon()
        XCTAssertEqual(upgradeSystem.weaponUpgradeLevel, 2)
    }

    func testPlayerCloneTakeDamage() {
        let clone = PlayerClone()
        clone.takeDamage(20)
        XCTAssertEqual(clone.health, 80 + (UpgradeSystem.shared.healthUpgradeLevel * 20))
    }
}
