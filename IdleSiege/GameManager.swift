import Foundation

class GameManager {
    static let shared = GameManager()

    private var lastOnlineTime: Date {
        get {
            return UserDefaults.standard.object(forKey: "lastOnlineTime") as? Date ?? Date()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastOnlineTime")
        }
    }

    private init() {}

    func applicationWillResignActive() {
        lastOnlineTime = Date()
    }

    func applicationDidBecomeActive() {
        let offlineTime = Date().timeIntervalSince(lastOnlineTime)
        let offlineResources = Int(offlineTime) * getResourceGenerationRate()
        ResourceManager.shared.addResource(offlineResources, type: .gold)
    }

    private func getResourceGenerationRate() -> Int {
        // This should be calculated based on the player's buildings
        return 1 // 1 gold per second for now
    }
}
