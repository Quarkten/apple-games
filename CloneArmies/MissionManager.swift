import Foundation

class MissionManager {
    static let shared = MissionManager()

    private var missions: [Mission] = []
    private var currentMissionIndex = 0

    private init() {
        loadMissions()
    }

    private func loadMissions() {
        // In a real game, you would load this from a file (e.g., a JSON file)
        missions = [
            Mission(missionID: 1, objectives: ["Defeat all enemies"], enemyTypes: [.sniper, .sniper], reward: 100),
            Mission(missionID: 2, objectives: ["Defeat all enemies"], enemyTypes: [.jetpack, .jetpack, .sniper], reward: 200),
            Mission(missionID: 3, objectives: ["Defeat all enemies"], enemyTypes: [.tank, .sniper], reward: 300),
            Mission(missionID: 4, objectives: ["Defeat the boss"], enemyTypes: [.tankBoss], reward: 1000)
        ]
    }

    func getCurrentMission() -> Mission? {
        guard currentMissionIndex < missions.count else { return nil }
        return missions[currentMissionIndex]
    }

    func advanceToNextMission() {
        currentMissionIndex += 1
    }
}
