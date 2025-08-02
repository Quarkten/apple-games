import Foundation

enum ResourceType: String, CaseIterable {
    case gold
    case cash
    case wood
    case stone
    case crystal
}

class ResourceManager {
    // Properties
    static let shared = ResourceManager()
    private var resources: [ResourceType: Int] = [:]

    // Private init for singleton
    private init() {
        for resourceType in ResourceType.allCases {
            resources[resourceType] = 0
        }
        resources[.gold] = 1000
        resources[.cash] = 100
    }

    // Methods
    func getResourceAmount(for type: ResourceType) -> Int {
        return resources[type] ?? 0
    }

    func addResource(_ amount: Int, type: ResourceType) {
        resources[type, default: 0] += amount
    }

    func spendResource(_ amount: Int, type: ResourceType) -> Bool {
        if getResourceAmount(for: type) >= amount {
            resources[type, default: 0] -= amount
            return true
        }
        return false
    }
}
