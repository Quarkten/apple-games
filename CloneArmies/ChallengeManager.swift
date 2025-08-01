import Foundation

class ChallengeManager {
    static let shared = ChallengeManager()

    private var challenges: [Challenge] = []

    private init() {
        loadChallenges()
    }

    private func loadChallenges() {
        // In a real game, you would load this from a server to get new weekly challenges
        challenges = [
            Challenge(challengeID: 1, title: "Survival", description: "Survive for 2 minutes", objective: .survive(duration: 120), reward: 500),
            Challenge(challengeID: 2, title: "Elimination", description: "Defeat 10 enemies", objective: .defeatEnemies(count: 10), reward: 500)
        ]
    }

    func getWeeklyChallenge() -> Challenge? {
        // For now, just return a random challenge. In a real game, you would have logic to determine the current weekly challenge.
        return challenges.randomElement()
    }
}
