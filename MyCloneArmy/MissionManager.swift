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
        let opponentArmy = ArmyState(clones: [
            CloneState(position: .zero, health: 100),
            CloneState(position: .zero, health: 100)
        ])
        missions = [
            Mission(title: "First Battle", description: "Defeat the enemy army.", aiOpponent: AIOpponent(army: opponentArmy), reward: ["coins": 100]),
            Mission(title: "Second Wave", description: "Survive the enemy onslaught.", aiOpponent: AIOpponent(army: opponentArmy), reward: ["coins": 200])
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
