import XCTest
@testable import IdleSiege

class IdleSiegeTests: XCTestCase {

    func testResourceManagerAddGold() {
        ResourceManager.shared.addResource(100, type: .gold)
        XCTAssertEqual(ResourceManager.shared.getResourceAmount(for: .gold), 1100)
    }

    func testBuildingUpgrade() {
        let building = Barracks()
        building.upgrade()
        XCTAssertEqual(building.level, 2)
    }

    func testTroopUpgrade() {
        let troop = Troop(type: .swordsman)
        troop.upgrade()
        XCTAssertEqual(troop.level, 2)
    }
}
