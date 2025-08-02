import XCTest
@testable import OneCloneLeft

class OneCloneLeftTests: XCTestCase {

    func testPlayerClone() {
        let player = Player()
        player.clone()
        XCTAssertEqual(player.clones.count, 1)
    }

    func testPerkSystem() {
        let player = Player()
        let perk = Perk(name: "Test Perk", description: "Test", effect: { p in
            p.health += 50
        })
        player.addPerk(perk)
        XCTAssertEqual(player.health, 150)
    }

    func testEnemyTakeDamage() {
        let enemy = Zombie(texture: nil, color: .green, size: .zero)
        // This is a placeholder for a takeDamage method which is not yet implemented
        // enemy.takeDamage(20)
        // XCTAssertEqual(enemy.health, 180)
    }
}
