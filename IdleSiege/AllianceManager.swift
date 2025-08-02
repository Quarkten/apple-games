import Foundation

struct Alliance {
    let name: String
    let members: [String]
}

class AllianceManager {
    static let shared = AllianceManager()

    private var alliances: [Alliance] = []
    private var myAlliance: Alliance?

    private init() {
        // In a real game, you would load this from a server
        alliances = [
            Alliance(name: "The First Order", members: ["Player 1", "Player 2"]),
            Alliance(name: "The Resistance", members: ["Player 3", "Player 4"])
        ]
    }

    func createAlliance(name: String) {
        let newAlliance = Alliance(name: name, members: ["MyPlayer"])
        alliances.append(newAlliance)
        myAlliance = newAlliance
    }

    func joinAlliance(_ alliance: Alliance) {
        // In a real game, you would send a request to join the alliance
        myAlliance = alliance
    }

    func leaveAlliance() {
        myAlliance = nil
    }

    func getAlliances() -> [Alliance] {
        return alliances
    }

    func getMyAlliance() -> Alliance? {
        return myAlliance
    }
}
