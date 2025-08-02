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
            Mission(missionID: 1, title: "First Encounter", objective: .defeatAllEnemies, enemyTypes: [.sniper], reward: 100),
            Mission(missionID: 2, title: "The Nest", objective: .defeatAllEnemies, enemyTypes: [.sniper, .sniper], reward: 200),
            Mission(missionID: 3, title: "Tank Attack", objective: .defeatAllEnemies, enemyTypes: [.tank], reward: 300),
            Mission(missionID: 4, title: "Jetpack Joyride", objective: .defeatAllEnemies, enemyTypes: [.jetpack, .jetpack], reward: 400),
            Mission(missionID: 5, title: "Survival 1", objective: .survive(duration: 30), enemyTypes: [.sniper], reward: 500),
            Mission(missionID: 6, title: "Survival 2", objective: .survive(duration: 60), enemyTypes: [.sniper, .jetpack], reward: 750),
            Mission(missionID: 7, title: "Boss Battle 1", objective: .defeatBoss, enemyTypes: [.tankBoss], reward: 1000),
            Mission(missionID: 8, title: "Mixed Forces", objective: .defeatAllEnemies, enemyTypes: [.sniper, .jetpack, .tank], reward: 600),
            Mission(missionID: 9, title: "The Horde", objective: .defeatAllEnemies, enemyTypes: [.sniper, .sniper, .sniper, .sniper, .sniper], reward: 800),
            Mission(missionID: 10, title: "Final Boss", objective: .defeatBoss, enemyTypes: [.tankBoss, .tankBoss], reward: 2000)
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
