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
            Mission(title: "The Beginning", description: "Clear the area of zombies.", objective: .defeatAllEnemies, enemyWaves: [[Zombie.self, Zombie.self]], reward: ["xp": 100]),
            Mission(title: "Survival", description: "Survive for 2 minutes.", objective: .survive(duration: 120), enemyWaves: [[Mutant.self], [Zombie.self, Mutant.self]], reward: ["xp": 200]),
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
