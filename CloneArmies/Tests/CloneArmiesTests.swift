import XCTest
@testable import CloneArmies

class CloneArmiesTests: XCTestCase {

    func testPlayerTakeDamage() {
        let player = Player(texture: nil, color: .blue, size: .zero, gameScene: nil)
        player.takeDamage(20)
        XCTAssertEqual(player.health, 80)
    }

    func testGameManagerAddResources() {
        GameManager.shared.addResources(100)
        XCTAssertEqual(GameManager.shared.resources, 1100)
    }

    func testMissionManagerGetCurrentMission() {
        let mission = MissionManager.shared.getCurrentMission()
        XCTAssertEqual(mission?.missionID, 1)
    }
}
