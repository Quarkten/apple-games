import Foundation

class OnlineManager {
    // Properties
    static let shared = OnlineManager()

    // Private init for singleton
    private init() {}

    private var leaderboard: [(String, Int)] = [
        ("Player 1", 1000),
        ("Player 2", 800),
        ("Player 3", 600)
    ]

    // Methods
    func submitScore(name: String, score: Int) {
        leaderboard.append((name, score))
        leaderboard.sort { $0.1 > $1.1 }
    }

    func getLeaderboard() -> [(String, Int)] {
        return leaderboard
    }

    func findMatch() {
        // Logic for matchmaking
    }
}
