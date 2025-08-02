import Foundation

class OnlineManager {
    static let shared = OnlineManager()

    private var leaderboard: [(String, Int)] = [
        ("Player 1", 1000),
        ("Player 2", 800),
        ("Player 3", 600)
    ]

    private init() {}

    func submitScore(name: String, score: Int) {
        leaderboard.append((name, score))
        leaderboard.sort { $0.1 > $1.1 }
    }

    func getLeaderboard() -> [(String, Int)] {
        return leaderboard
    }
}
