import XCTest
@testable import TactileWars

class TactileWarsTests: XCTestCase {

    func testTroopTakeDamage() {
        let troop = Troop(type: .infantry)
        troop.takeDamage(20)
        XCTAssertEqual(troop.health, 80)
    }

    func testDefenseStructureTakeDamage() {
        let defense = Mine(texture: nil, color: .red, size: .zero)
        defense.takeDamage(50)
        XCTAssertEqual(defense.health, 150)
    }

    func testDamageCalculator() {
        let troop = Troop(type: .infantry)
        let defense = Cannon(texture: nil, color: .black, size: .zero)
        let damage = DamageCalculator.calculateDamage(attacker: troop, defender: defense)
        XCTAssertEqual(damage, 15)
    }
}
